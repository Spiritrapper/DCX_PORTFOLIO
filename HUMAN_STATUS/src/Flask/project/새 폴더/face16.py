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
from PIL import ImageFont, ImageDraw, Image
import mediapipe as mp
import pickle
import joblib
import warnings
import math
from datetime import datetime
from sklearn.exceptions import InconsistentVersionWarning

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

# body_language_model 초기화
body_language_model = None
try:
    # Load the body_language_model
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

# 어깨 각도 계산 함수
def calculate_angle(a, b):
    angle = math.atan2(b[1] - a[1], b[0] - a[0])
    return math.degrees(angle)

# 추가된 졸음 감지 함수
def detect_sleepiness(ear, angle):
    if ear < 0.25 or angle < 175:
        return True
    return False

# detect_pose 함수 수정
def detect_pose(frame, pose, body_language_model):
    rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    results = pose.process(rgb_frame)

    if results.pose_landmarks:
        mp.solutions.drawing_utils.draw_landmarks(frame, results.pose_landmarks, mp_pose.POSE_CONNECTIONS)
        landmarks = results.pose_landmarks.landmark
        left_shoulder = [landmarks[mp_pose.PoseLandmark.LEFT_SHOULDER.value].x, landmarks[mp_pose.PoseLandmark.LEFT_SHOULDER.value].y]
        right_shoulder = [landmarks[mp_pose.PoseLandmark.RIGHT_SHOULDER.value].x, landmarks[mp_pose.PoseLandmark.RIGHT_SHOULDER.value].y]
        angle = calculate_angle(left_shoulder, right_shoulder)

    return frame, results

# 한글 텍스트 그리는 함수
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
        status_values = [0, 0, 0, 0]

        for i, region in enumerate(regions):
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
                both_ear = (leftEAR + rightEAR) / 2.0

                # detect_pose 함수 호출
                updated_frame, results = detect_pose(frame, pose, body_language_model)
                if results is not None:
                     frame = updated_frame

                # 어깨 각도 및 눈 종횡비에 따른 졸음 상태 결정
                is_sleepy = False
                if results and results.pose_landmarks:
                    left_shoulder = [results.pose_landmarks.landmark[mp_pose.PoseLandmark.LEFT_SHOULDER.value].x, results.pose_landmarks.landmark[mp_pose.PoseLandmark.LEFT_SHOULDER.value].y]
                    right_shoulder = [results.pose_landmarks.landmark[mp_pose.PoseLandmark.RIGHT_SHOULDER.value].x, results.pose_landmarks.landmark[mp_pose.PoseLandmark.RIGHT_SHOULDER.value].y]
                    shoulder_angle = calculate_angle(left_shoulder, right_shoulder)
                    is_sleepy = detect_sleepiness(both_ear, shoulder_angle)

                if is_sleepy:
                    user_state["COUNTER"] += 1
                    if user_state["COUNTER"] >= user_state["eye_CONSEC_FRAMES"]:
                        if not user_state["TIMER_FLAG"]:
                            user_state["start_closing"] = timeit.default_timer()
                            user_state["TIMER_FLAG"] = True
                        user_state["ALERT"] = True
                else:
                    if user_state["ALERT"] and not user_state["TIMER_FLAG"]:
                        user_state["TIMER_FLAG"] = True
                        user_state["start_closing"] = timeit.default_timer()
                    elif not user_state["ALERT"] and user_state["TIMER_FLAG"]:
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

            if user_state["ALERT"]==False:
                # 깜빡임 상태를 토글합니다.
                user_state["blink"] = not user_state["blink"]
                if user_state["blink"]:
                    overlay = frame.copy()
                    cv2.rectangle(overlay, (0, 0), (frame.shape[1], frame.shape[0]), (0, 0, 255), -1)
                    cv2.addWeighted(overlay, 0.5, frame, 0.5, 0, frame)


            # 스켈레톤 모델을 사용한 포즈 감지 및 시각화
            frame = detect_pose(frame, pose, body_language_model)

            if isinstance(frame, np.ndarray):
                if not user_state["ALERT"]:
                    frame = draw_korean_text(frame, "집중", (50, 100), r"C:\eGovFrame-4.0.0\workspace.edu\Z_Project5\NanumGothic.ttf", 100, (0, 255, 0))
                else:
                    frame = draw_korean_text(frame, "졸음!", (50, 100), r"C:\eGovFrame-4.0.0\workspace.edu\Z_Project5\NanumGothic.ttf", 100, (0, 0, 255))
                    status_values[i] = 1

                frames.append(frame)
            else:
                print("오류: frame은 NumPy 배열이어야 합니다.")

            status_values[i] = 1 if user_state["ALERT"] else 0

            if current_time - user_state["last_update_time"] >= 2:  # 2초마다 상태 업데이트
                status_values[i] = 1 if user_state["ALERT"] else 0
                user_state["last_update_time"] = current_time

        # 데이터베이스에 상태 업데이트
        dt = datetime.fromtimestamp(current_time)
        current_timestamp = dt.strftime('%Y-%m-%d')
        try:
            query = "INSERT INTO Tester3 (timestamp, st1, st2, st3, st4 ) VALUES (%s, %s, %s, %s, %s)"
            val = (current_timestamp, *status_values)
            cursor.execute(query, val)
            db.commit()
        except mysql.connector.Error as err:
            print(f"Database Error: {err}")



        frames.append(frame)
        if len(frames) == 4:
            global_frame = combine_frames(frames, 1600, 1000)
        else:
            print(f"오류: 프레임이 충분하지 않습니다. 현재 프레임 수: {len(frames)}")
        time.sleep(0.05)




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

    app.run(host='0.0.0.0', port=5000)
