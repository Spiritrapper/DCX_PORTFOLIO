import cv2
import dlib
from imutils import face_utils
import numpy as np
import pyautogui
import time
import threading
from flask import Flask, Response, render_template
from scipy.spatial import distance as dist
import os
import mysql.connector
import timeit
from datetime import datetime
from scipy.spatial import distance as dist
import os 
import imutils

# Flask 애플리케이션 설정
template_dir = os.path.abspath('C:/eGovFrame-4.0.0/workspace.edu/Z_Project5/src/main/resources/templates')

app = Flask(__name__, template_folder=template_dir)
# Dlib 얼굴 감지 및 눈 비율 계산 준비
db = mysql.connector.connect(
    host="project-db-campus.smhrd.com",
    port=3312,
    user="seocho_22K_DCX_final_2",
    password="smhrd2",
    database="seocho_22K_DCX_final_2"
)
cursor = db.cursor()


detector = dlib.get_frontal_face_detector()
predictor_path = "C:/eGovFrame-4.0.0/workspace.edu/Z_Project5/src/Flask/project/shape_predictor_68_face_landmarks.dat"
predictor = dlib.shape_predictor(predictor_path)
(lStart, lEnd) = face_utils.FACIAL_LANDMARKS_IDXS["left_eye"]
(rStart, rEnd) = face_utils.FACIAL_LANDMARKS_IDXS["right_eye"]

# 눈 종횡비 계산 함수
def eye_aspect_ratio(eye):
    A = dist.euclidean(eye[1], eye[5])
    B = dist.euclidean(eye[2], eye[4])
    C = dist.euclidean(eye[0], eye[3])
    ear = (A + B) / (2.0 * C)
    return ear

# 사용자 상태 초기화 함수
def init_user_state():
    return {
        "eye_THRESH": 0.25,
        "eye_CONSEC_FRAMES": 48,
        "COUNTER": 0,
        "ALERT": False,
        "TIMER_FLAG": False,
        "start_closing": 0,
        "end_closing": 0,
        "last_update_time": time.time()  # 이 줄을 추가하세요
    }

# 프레임 합치기 함수
def combine_frames(frames, screen_width, screen_height):
    top_half = np.hstack((frames[0], frames[1]))
    bottom_half = np.hstack((frames[2], frames[3]))
    combined_frame = np.vstack((top_half, bottom_half))
    combined_frame = cv2.resize(combined_frame, (screen_width, screen_height))
    return combined_frame

# 비디오 캡처 함수
# ... [이전 코드의 나머지 부분] ...

# 비디오 캡처 함수
def capture_video():
    global global_frame
    regions = [
        (0, 0, 800, 500),   # 구역 1
        (800, 0, 800, 500), # 구역 2
        (0, 500, 800, 500), # 구역 3
        (800, 500, 800, 500) # 구역 4
    ]
    user_states = {1: init_user_state(), 2: init_user_state(), 3: init_user_state(), 4: init_user_state()}

    while True:
        frames = []
        for i, region in enumerate(regions):
            screenshot = pyautogui.screenshot(region=region)
            frame = np.array(screenshot)
            frame = cv2.cvtColor(frame, cv2.COLOR_RGB2BGR)
            gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
            rects = detector(gray, 0)

            user_state = user_states[i + 1]
            user_state["ALERT"] = False

            for rect in rects:
                shape = predictor(gray, rect)
                shape = face_utils.shape_to_np(shape)
                leftEye = shape[lStart:lEnd]
                rightEye = shape[rStart:rEnd]
                leftEAR = eye_aspect_ratio(leftEye)
                rightEAR = eye_aspect_ratio(rightEye)
                both_eye = (leftEAR + rightEAR) * 500
                leftEyeHull = cv2.convexHull(leftEye)
                rightEyeHull = cv2.convexHull(rightEye)
                cv2.drawContours(frame, [leftEyeHull], -1, (0, 255, 0), 1)
                cv2.drawContours(frame, [rightEyeHull], -1, (0, 255, 0), 1)
                both_ear = (leftEAR + rightEAR) / 2.0

                if both_ear < user_state["eye_THRESH"]:
                    user_state["COUNTER"] += 1
                    if user_state["COUNTER"] >= user_state["eye_CONSEC_FRAMES"]:
                        if not user_state["TIMER_FLAG"]:
                            user_state["start_closing"] = timeit.default_timer()
                            user_state["TIMER_FLAG"] = True
                        user_state["ALERT"] = True
                else:
                    if user_state["TIMER_FLAG"]:
                        user_state["end_closing"] = timeit.default_timer()
                        sleep_duration = user_state["end_closing"] - user_state["start_closing"]
                        if sleep_duration >= 1:
                            # T_USER_SLEEP1 테이블에 데이터 저장
                            query = "INSERT INTO T_USER_SLEEP1 (region_id, sleep_status, duration) VALUES (%s, %s, %s)"
                            val = (i + 1, 1, sleep_duration) 
                            cursor.execute(query, val)
                            db.commit()
                        user_state["TIMER_FLAG"] = False
                    user_state["COUNTER"] = 0


            # # 경고 이미지 불러오기
            # warning_img = cv2.imread('path_to_warning_image.png')

            # # 이미지 크기 조정 및 위치 지정
            # resized_warning_img = cv2.resize(warning_img, (100, 100))  # 예: 100x100 크기로 조정
            # x_offset, y_offset = 50, 50  # 이미지를 놓을 위치

            # # 화면에 이미지 오버레이
            # if user_state["ALERT"]:
            #     frame[y_offset:y_offset+resized_warning_img.shape[0], x_offset:x_offset+resized_warning_img.shape[1]] = resized_warning_img

            if user_state["ALERT"]:
                overlay = frame.copy()
                cv2.rectangle(overlay, (0, 0), (frame.shape[1], frame.shape[0]), (0, 0, 255), -1)  # 레드 오버레이 생성
                cv2.addWeighted(overlay, 0.5, frame, 0.5, 0, frame)  # 반투명 효과 적용
                
            # 경고 상태 표시 및 Tester3 테이블에 데이터 저장
            status = 1 if user_state["ALERT"] else 0
            cv2.putText(frame, "ALERT!" if user_state["ALERT"] else "Normal", (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255) if user_state["ALERT"] else (0, 255, 0), 2)
            frames.append(frame)

            # Tester3 테이블에 2초마다 상태 업데이트
            current_time = time.time()
            if current_time - user_state["last_update_time"] >= 2:
                query = f"UPDATE Tester3 SET status{i + 1} = %s WHERE region_id = %s"
                val = (status, i + 1)
                cursor.execute(query, val)
                db.commit()
                user_state["last_update_time"] = current_time

        global_frame = combine_frames(frames, 1600, 1000)
        time.sleep(0.1)

# ... [Flask 애플리케이션 및 라우트 정의 코드] ...


@app.route('/video_feed')
def video_feed():
    def generate():
        global global_frame
        while True:
            if global_frame is not None:
                ret, jpeg = cv2.imencode('.jpg', global_frame)
                frame_data = jpeg.tobytes()
                yield (b'--frame\r\n'
                       b'Content-Type: image/jpeg\r\n\r\n' + frame_data + b'\r\n\r\n')
            time.sleep(0.1)

    return Response(generate(), mimetype='multipart/x-mixed-replace; boundary=frame')

@app.route('/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    global_frame = None
    threading.Thread(target=capture_video, daemon=True).start()
    app.run(host='0.0.0.0', port=5000)
