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

   # 쿼리를 실행하여 각 구역의 상태를 0으로 초기화합니다.
    try:
        query = "INSERT INTO Tester3 (region_id1, region_id2, region_id3, region_id4) VALUES (0, 0, 0, 0)"
        cursor.execute(query)
        db.commit()
    except mysql.connector.Error as err:
        print(f"Initial DB Insert Error: {err}")


    while True:
        frames = []
        status_values = [0, 0, 0, 0]  # 네 개의 구역 상태를 저장할 리스트

        for i, region in enumerate(regions):
            # ... [프레임 캡처 및 처리 로직] ...
            screenshot = pyautogui.screenshot(region=region)
            frame = np.array(screenshot)
            frame = cv2.cvtColor(frame, cv2.COLOR_RGB2BGR)
            gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
            rects = detector(gray, 0)

            user_state = user_states[i + 1]
            user_state["ALERT"] = False

            # 경고 상태 표시 및 Tester3 테이블에 데이터 저장
            status_values  = 1 if user_state["ALERT"] else 0
            cv2.putText(frame, "ALERT!" if user_state["ALERT"] else "Normal", (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255) if user_state["ALERT"] else (0, 255, 0), 2)
            

            # ... [프레임 처리 로직] ...
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
                    try:
                        if user_state["ALERT"] and not user_state["TIMER_FLAG"]:
                            # 잠든 상태 감지 및 타이머 시작
                            user_state["TIMER_FLAG"] = True
                            user_state["start_closing"] = timeit.default_timer()
                        elif not user_state["ALERT"] and user_state["TIMER_FLAG"]:
                            # 잠든 상태 해제 및 지속 시간 계산
                            user_state["end_closing"] = timeit.default_timer()
                            sleep_duration = user_state["end_closing"] - user_state["start_closing"]
                            if sleep_duration >= 1:
                                # 데이터베이스에 기록
                                query = "INSERT INTO T_USER_SLEEP1 (region_id, sleep_status, duration) VALUES (%s, %s, %s)"
                                val = (i + 1, 1, sleep_duration)
                                cursor.execute(query, val)
                                db.commit()
                            user_state["TIMER_FLAG"] = False
                        user_state["COUNTER"] = 0 if not user_state["ALERT"] else user_state["COUNTER"]
                    except mysql.connector.Error as err:
                        print(f"Error: {err}")


            #     frame[y_offset:y_offset+resized_warning_img.shape[0], x_offset:x_offset+resized_warning_img.shape[1]] = resized_warning_img

            if user_state["ALERT"]:
                overlay = frame.copy()
                cv2.rectangle(overlay, (0, 0), (frame.shape[1], frame.shape[0]), (0, 0, 255), -1)  # 레드 오버레이 생성
                cv2.addWeighted(overlay, 0.5, frame, 0.5, 0, frame)  # 반투명 효과 적용
                


            user_state = user_states[i + 1]

                # 각 구역의 상태를 결정하고 ALERT 상태를 설정합니다.
            if time.time() - user_state['last_update_time'] >= 2:
                user_state['last_update_time'] = time.time()
                status_values[i] = 1 if user_state["ALERT"] else 0

            frames.append(frame)

            # 새로운 상태 레코드를 데이터베이스에 추가합니다.
            try:
                query = "INSERT INTO Tester4 (region_id1, region_id2, region_id3, region_id4) VALUES (%s, %s, %s, %s)"
                cursor.execute(query, tuple(status_values))
                db.commit()
            except mysql.connector.Error as err:
                print(f"Database Error: {err}")

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
