import cv2
import dlib
from imutils import face_utils
import numpy as np
import pyautogui
import threading
import time
from flask import Flask, Response, render_template
from scipy.spatial import distance as dist
import os
import mysql.connector
import timeit
from PIL import ImageFont, ImageDraw, Image
import mediapipe as mp
import pickle
import warnings
from sklearn.exceptions import InconsistentVersionWarning
from queue import Queue
from datetime import datetime

# 경고 필터 설정
warnings.simplefilter("error", InconsistentVersionWarning)

# Flask 애플리케이션 설정
template_dir = os.path.abspath('C:/eGovFrame-4.0.0/workspace.edu/Z_Project5/src/main/resources/templates')
app = Flask(__name__, template_folder=template_dir)

# 데이터베이스 연결 설정
db = mysql.connector.connect(
    host="project-db-campus.smhrd.com",
    port=3312,
    user="seocho_22K_DCX_final_2",
    password="smhrd2",
    database="seocho_22K_DCX_final_2"
)
cursor = db.cursor()

# body_language_model 불러오기
body_language_model = None
try:
    body_language_model_path = 'C:/eGovFrame-4.0.0/workspace.edu/Z_Project5/src/Flask/project/Body-Langugae-Decoder-Using-Mediapipe-master/body_language.pkl'
    with open(body_language_model_path, 'rb') as f:
        body_language_model = pickle.load(f)
except InconsistentVersionWarning as w:
    print(f"Version Warning: {w}")

# Dlib 얼굴 감지 및 눈 비율 계산 준비
detector = dlib.get_frontal_face_detector()
predictor_path = "C:/eGovFrame-4.0.0/workspace.edu/Z_Project5/src/Flask/project/shape_predictor_68_face_landmarks.dat"
predictor = dlib.shape_predictor(predictor_path)
(lStart, lEnd) = face_utils.FACIAL_LANDMARKS_IDXS["left_eye"]
(rStart, rEnd) = face_utils.FACIAL_LANDMARKS_IDXS["right_eye"]

# 포즈 감지 설정
mp_pose = mp.solutions.pose
pose = mp_pose.Pose(static_image_mode=False, min_detection_confidence=0.5, min_tracking_confidence=0.5)

# 전역 변수 및 큐 설정
frame_queue = Queue(maxsize=10)
db_queue = Queue(maxsize=10)
global_frame = None

def detect_pose(frame, pose, body_language_model):
    # 이미지를 BGR에서 RGB로 변환
    rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    results = pose.process(rgb_frame)

    if results.pose_landmarks:
        mp.solutions.drawing_utils.draw_landmarks(frame, results.pose_landmarks, mp_pose.POSE_CONNECTIONS)
        # body_language_model을 사용한 추가 처리
        # ...

    return frame

# 여기부터 나머지 함수들 (draw_korean_text, eye_aspect_ratio, init_user_state, combine_frames)은 그대로 유지합니다.
def draw_korean_text(image, text, position, font_path, font_size, font_color):

    font_path = os.path.abspath(r"C:\eGovFrame-4.0.0\workspace.edu\Z_Project5\NanumGothic.ttf")
    image_pil = Image.fromarray(image)
    draw = ImageDraw.Draw(image_pil)
    font = ImageFont.truetype(font_path, font_size)
    draw.text(position, text, font=font, fill=font_color)
    return np.array(image_pil)



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
        "last_update_time": time.time(),
        "blink": False
    }

# 프레임 합치기 함수
def combine_frames(frames, screen_width, screen_height):
    top_half = np.hstack((frames[0], frames[1]))
    bottom_half = np.hstack((frames[2], frames[3]))
    combined_frame = np.vstack((top_half, bottom_half))
    combined_frame = cv2.resize(combined_frame, (screen_width, screen_height))
    return combined_frame


# 비디오 캡처 함수
def capture_video():
    global frame_queue
    regions = [(0, 0, 800, 500), (800, 0, 800, 500), (0, 500, 800, 500), (800, 500, 800, 500)]
    user_states = {1: init_user_state(), 2: init_user_state(), 3: init_user_state(), 4: init_user_state()}

    while True:
        frames = []
        status_values = [0, 0, 0, 0]

        for i, region in enumerate(regions):
            # 스크린샷 및 처리 로직
            screenshot = pyautogui.screenshot(region=region)
            frame = np.array(screenshot)
            frame = cv2.cvtColor(frame, cv2.COLOR_RGB2BGR)
            gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
            rects = detector(gray, 0)

            user_state = user_states[i + 1]
            user_state["ALERT"] = False
            
            current_time = time.time()

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

            if user_state["ALERT"]==False:
                # 깜빡임 상태를 토글합니다.
                user_state["blink"] = not user_state["blink"]
                if user_state["blink"]:
                    overlay = frame.copy()
                    cv2.rectangle(overlay, (0, 0), (frame.shape[1], frame.shape[0]), (0, 0, 255), -1)
                    cv2.addWeighted(overlay, 0.5, frame, 0.5, 0, frame)


            # 스켈레톤 모델을 사용한 포즈 감지 및 시각화
            frame = detect_pose(frame, pose, body_language_model)


            if user_state["ALERT"]:
                # 한글 텍스트 렌더링을 위한 코드
                frame = draw_korean_text(frame, "졸음!", (50, 100), r"C:\eGovFrame-4.0.0\workspace.edu\Z_Project5\NanumGothic.ttf", 100, (0, 0, 255))
            else:
                frame = draw_korean_text(frame, "집중", (50, 100), r"C:\eGovFrame-4.0.0\workspace.edu\Z_Project5\NanumGothic.ttf", 100, (0, 255, 0))
            
            frames.append(frame)

            status_values[i] = 1 if user_state["ALERT"] else 0

            if current_time - user_state["last_update_time"] >= 2:  # 2초마다 상태 업데이트
                status_values[i] = 1 if user_state["ALERT"] else 0
                user_state["last_update_time"] = current_time
            current_time = time.time()
            dt = datetime.fromtimestamp(current_time)
            current_timestamp = dt.strftime('%Y-%m-%d')
            try:
                query = "INSERT INTO Tester3 (timestamp, st1, st2, st3, st4 ) VALUES (%s, %s, %s, %s, %s)"
                val = (current_timestamp, *status_values)
                cursor.execute(query, val)
                db.commit()
            except mysql.connector.Error as err:
                print(f"Database Error: {err}")



                # 데이터베이스 큐에 상태 추가
                if user_state["ALERT"]:
                    db_queue.put((i + 1, 1, sleep_duration))

                frames.append(frame)

        combined_frame = combine_frames(frames, 1600, 1000)
        frame_queue.put(combined_frame)

# 데이터베이스 작업 함수
def database_write():
    global db_queue
    while True:
        if not db_queue.empty():
            region_id, sleep_status, duration = db_queue.get()
            # 데이터베이스 쓰기 작업
            # ...

# Flask 비디오 스트리밍 함수
@app.route('/video_feed')
def video_feed():
    global frame_queue
    def generate():
        while True:
            if not frame_queue.empty():
                frame = frame_queue.get()
                ret, jpeg = cv2.imencode('.jpg', frame)
                frame_data = jpeg.tobytes()
                yield (b'--frame\r\n' b'Content-Type: image/jpeg\r\n\r\n' + frame_data + b'\r\n\r\n')

    return Response(generate(), mimetype='multipart/x-mixed-replace; boundary=frame')

@app.route('/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    threading.Thread(target=capture_video, daemon=True).start()
    threading.Thread(target=database_write, daemon=True).start()
    app.run(host='0.0.0.0', port=5000)
