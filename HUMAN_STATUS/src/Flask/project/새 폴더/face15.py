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
from datetime import datetime
import mediapipe as mp
import pickle
from PIL import ImageFont, ImageDraw, Image

# 경고 필터 설정
import warnings
from sklearn.exceptions import InconsistentVersionWarning
warnings.simplefilter("error", InconsistentVersionWarning)

# Flask 애플리케이션 및 데이터베이스 설정
app = Flask(__name__, template_folder=os.path.abspath('C:/eGovFrame-4.0.0/workspace.edu/Z_Project5/src/main/resources/templates'))
db = mysql.connector.connect(
    host="project-db-campus.smhrd.com", port=3312, user="seocho_22K_DCX_final_2",
    password="smhrd2", database="seocho_22K_DCX_final_2"
)
cursor = db.cursor()

# body_language 모델 불러오기
try:
    with open('C:/eGovFrame-4.0.0/workspace.edu/Z_Project5/src/Flask/project/Body-Langugae-Decoder-Using-Mediapipe-master/body_language.pkl', 'rb') as f:
        body_language_model = pickle.load(f)
except InconsistentVersionWarning as w:
    print(f"Version Warning: {w}")

# Dlib 및 Mediapipe 설정
detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor("C:/eGovFrame-4.0.0/workspace.edu/Z_Project5/src/Flask/project/shape_predictor_68_face_landmarks.dat")
(lStart, lEnd) = face_utils.FACIAL_LANDMARKS_IDXS["left_eye"]
(rStart, rEnd) = face_utils.FACIAL_LANDMARKS_IDXS["right_eye"]
pose = mp.solutions.pose.Pose(static_image_mode=False, min_detection_confidence=0.5, min_tracking_confidence=0.5)

# 글로벌 변수
global_frame = None

def detect_pose(frame):
    rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    results = pose.process(rgb_frame)
    if results.pose_landmarks:
        mp.solutions.drawing_utils.draw_landmarks(frame, results.pose_landmarks, mp.solutions.pose.POSE_CONNECTIONS)
    return frame

def draw_korean_text(image, text, position, font_size, font_color):
    font_path = "C:/eGovFrame-4.0.0/workspace.edu/Z_Project5/NanumGothic.ttf"
    image_pil = Image.fromarray(image)
    draw = ImageDraw.Draw(image_pil)
    font = ImageFont.truetype(font_path, font_size)
    draw.text(position, text, font=font, fill=font_color)
    return np.array(image_pil)

def eye_aspect_ratio(eye):
    A = dist.euclidean(eye[1], eye[5])
    B = dist.euclidean(eye[2], eye[4])
    C = dist.euclidean(eye[0], eye[3])
    return (A + B) / (2.0 * C)

def init_user_state():
    return {"eye_THRESH": 0.25, "eye_CONSEC_FRAMES": 48, "COUNTER": 0, "ALERT": False, "TIMER_FLAG": False, "last_update_time": time.time(), "blink": False}

def capture_video():
    global global_frame
    regions = [(0, 0, 800, 500), (800, 0, 800, 500), (0, 500, 800, 500), (800, 500, 800, 500)]
    user_states = {1: init_user_state(), 2: init_user_state(), 3: init_user_state(), 4: init_user_state()}

    while True:
        frames = []
        status_values = [0, 0, 0, 0]
        current_time = time.time()

        for i, region in enumerate(regions):
            screenshot = pyautogui.screenshot(region=region)
            frame = np.array(screenshot)
            frame = cv2.cvtColor(frame, cv2.COLOR_RGB2BGR)
            frame = detect_pose(frame)

            gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
            rects = detector(gray, 0)
            user_state = user_states[i + 1]

            for rect in rects:
                shape = predictor(gray, rect)
                shape = face_utils.shape_to_np(shape)
                leftEye = shape[lStart:lEnd]
                rightEye = shape[rStart:rEnd]
                ear = (eye_aspect_ratio(leftEye) + eye_aspect_ratio(rightEye)) / 2.0

                if ear < user_state["eye_THRESH"]:
                    user_state["COUNTER"] += 1
                    if user_state["COUNTER"] >= user_state["eye_CONSEC_FRAMES"]:
                        user_state["ALERT"] = True
                        if not user_state["TIMER_FLAG"]:
                            user_state["start_closing"] = time.time()
                            user_state["TIMER_FLAG"] = True
                else:
                    if user_state["ALERT"] and user_state["TIMER_FLAG"]:
                        sleep_duration = time.time() - user_state["start_closing"]
                        cursor.execute("INSERT INTO T_USER_SLEEP1 (region_id, sleep_status, duration) VALUES (%s, %s, %s)", (i + 1, 1, sleep_duration))
                        db.commit()
                        user_state["TIMER_FLAG"] = False
                    user_state["COUNTER"] = 0
                    user_state["ALERT"] = False

            frames.append(frame)
            status_values[i] = int(user_state["ALERT"])
            user_state["last_update_time"] = current_time

        if current_time - user_state["last_update_time"] >= 2:  # 2초마다 상태 업데이트
            dt = datetime.fromtimestamp(current_time)
            current_timestamp = dt.strftime('%Y-%m-%d')
            cursor.execute("INSERT INTO Tester3 (region_id1, region_id2, region_id3, region_id4, timestamp) VALUES (%s, %s, %s, %s, %s)", (*status_values, current_timestamp))
            db.commit()

        combined_frame = np.vstack((np.hstack(frames[:2]), np.hstack(frames[2:])))
        combined_frame = cv2.resize(combined_frame, (1600, 1000))
        global_frame = combined_frame
        time.sleep(0.1)  # 조절 가능한 프레임 레이트

# Flask 라우트
@app.route('/video_feed')
def video_feed():
    def generate():
        global global_frame
        while True:
            if global_frame is not None:
                ret, jpeg = cv2.imencode('.jpg', global_frame)
                frame_data = jpeg.tobytes()
                yield (b'--frame\r\n' b'Content-Type: image/jpeg\r\n\r\n' + frame_data + b'\r\n\r\n')
            time.sleep(0.1)

    return Response(generate(), mimetype='multipart/x-mixed-replace; boundary=frame')

@app.route('/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    threading.Thread(target=capture_video, daemon=True).start()
    app.run(host='0.0.0.0', port=5000)
