from flask import Flask, Response, render_template
import threading
import cv2
import dlib
from imutils import face_utils
import numpy as np
import pyautogui
import mysql.connector
import time
import timeit
from datetime import datetime
from scipy.spatial import distance as dist
import os 
import imutils


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

# Dlib 얼굴 감지 및 눈 비율 계산 준비
detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor("C:\eGovFrame-4.0.0\workspace.edu\Z_Project5\src\Flask\project\shape_predictor_68_face_landmarks.dat")
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

# 사용자 상태 초기화 함수
def init_user_state():
    return {"OPEN_eye": 0, "eye_THRESH": 200, "eye_CONSEC_FRAMES": 3, 
            "COUNTER": 0, "TIMER_FLAG": False, "both_eye": 0, 
            "normal_duration": 0, "last_update_time": time.time()}

# 사용자 상태 딕셔너리 초기화
user_states = {}
status_update_interval = 2  # 2초로 설정

# 화면 캡처 및 이미지 처리를 위한 함수
# 화면 캡처 및 이미지 처리를 위한 함수

        # Dlib 얼굴 감지

def light_removing(frame) :
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    lab = cv2.cvtColor(frame, cv2.COLOR_BGR2LAB)
    L = lab[:,:,0]
    med_L = cv2.medianBlur(L,99) #median filter
    invert_L = cv2.bitwise_not(med_L) #invert lightness
    composed = cv2.addWeighted(gray, 0.75, invert_L, 0.25, 0)
    return L, composed

def capture_video():
    global global_frame
    while True:
        # Zoom 화면 캡처
        screenshot = pyautogui.screenshot(region=(0, 0, 1600, 1000))
        frame = np.array(screenshot)
        frame = cv2.cvtColor(frame, cv2.COLOR_RGB2BGR)

        # Dlib 얼굴 감지
        L, gray = light_removing(frame)
        rects = detector(gray, 0)


        # 감지된 얼굴 수에 따라 사용자 상태 딕셔너리를 업데이트합니다.
        # for i in range(len(rects), len(user_states)):
        #     user_states.popitem()
        # for i in range(len(user_states), len(rects)):
        #     user_states[i + 1] = init_user_state()
        for i in range(len(rects), len(user_states)):
            user_states.popitem()
        for i in range(len(rects)):
            user_states[i + 1] = init_user_state()

           # 모든 상태값을 NULL로 초기화
        st_values = [None] * len(user_states)
        status_values = ['0'] * len(user_states)

        for i, rect in enumerate(rects):
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
            current_time = time.time()

            # 사용자 상태 업데이트
            user_no = i + 1
            user_state = user_states[user_no]
            user_state["both_eye"] = both_eye

            # 초기화
            status = '0'

            if both_eye < user_state["eye_THRESH"]:
                user_state["COUNTER"] += 1
                if user_state["COUNTER"] >= user_state["eye_CONSEC_FRAMES"]:
                    if not user_state["TIMER_FLAG"]:
                        user_state["start_closing"] = timeit.default_timer()
                        user_state["TIMER_FLAG"] = True
                    status = '1'
            else:
                #status = '0'
                if user_state["TIMER_FLAG"]:
                    user_state["end_closing"] = timeit.default_timer()
                    sleep_duration = user_state["end_closing"] - user_state["start_closing"]
                    if sleep_duration >= 1:
                        query = "INSERT INTO t_user_sleep(st, sleep_time, nomal_time) VALUES (%s, %s, %s)"
                        val = (user_no, sleep_duration, user_state["normal_duration"])
                        cursor.execute(query, val)
                        db.commit()
                    user_state["TIMER_FLAG"] = False
                user_state["COUNTER"] = 0

            # 상태를 화면에 출력
            cv2.putText(frame, f"Status : {status}, both_eye : {both_eye:.2f}", (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255) if status == 'sleep' else (0, 255, 0), 2)
            if current_time - user_state["last_update_time"] >= status_update_interval:  # 2초마다 상태 업데이트
                if 1 <= user_no <= 4:
                 
                    # 얼굴 인식 번호에 따라 해당 인덱스의 상태값을 업데이트
                    st_values[user_no - 1] = status
                    dt = datetime.fromtimestamp(current_time)
                    current_timestamp = dt.strftime('%Y-%m-%d %H:%M:%S')
                    query = f"INSERT INTO Tester1(st1, st2, st3, st4, timestamp) VALUES (%s, %s, %s, %s, %s)"
                    print(query)
                    val = (*st_values, current_timestamp)  # 이 부분 수정
                    #val = tuple(st_values + [current_timestamp])
                    cursor.execute(query, val)
                    db.commit()
                user_state["last_update_time"] = current_time

        global_frame = frame
        time.sleep(0.1)

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
