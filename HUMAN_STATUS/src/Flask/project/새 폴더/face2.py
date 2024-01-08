from ultralytics import YOLO
import cv2
import mysql.connector
import time
import timeit
from datetime import datetime
import pyautogui
import numpy as np
from flask import Flask, Response, render_template
import threading
from flask_cors import CORS
import os

# Flask 애플리케이션 초기화
template_dir = os.path.abspath('C:/eGovFrame-4.0.0/workspace.edu/Z_Project5/src/main/resources/templates')

app = Flask(__name__, template_folder=template_dir)

CORS(app)

# YOLO 모델 로드
model = YOLO("C:\\eGovFrame-4.0.0\\workspace.edu\\Z_Project5\\src\\Flask\\project\\face.pt")

# 데이터베이스 연결 설정
db = mysql.connector.connect(
    host="project-db-campus.smhrd.com",
    port=3312,
    user="seocho_22K_DCX_final_2",
    password="smhrd2",
    database="seocho_22K_DCX_final_2"
)
cursor = db.cursor()

# 사용자 상태 추적을 위한 초기 설정
user_states = {
    1: {"both_eye": 0, "eye_THRESH": 0.25, "COUNTER": 0, "eye_CONSEC_FRAMES": 15, "TIMER_FLAG": False, "normal_duration": 0, "last_update_time": time.time()},
    # 여기에 추가 사용자 상태 정보 추가 가능
}

# 화면 캡처 및 이미지 처리를 위한 함수
def capture_video():
    global global_frame
    while True:
        # Zoom 화면 캡처
        screenshot = pyautogui.screenshot(region=(0, 0, 800, 600))
        frame = np.array(screenshot)
        frame = cv2.cvtColor(frame, cv2.COLOR_RGB2BGR)

        # YOLO 모델을 사용하여 객체 감지
        results = model.predict(frame, conf=0.5)
        # 객체 감지 및 사용자 상태 추적 로직...
        for i, result in enumerate(results):
            user_no = i + 1
            user_state = user_states[user_no]
                # status 및 both_eye 초기화
            status = '0'  # 기본 상태를 '0' (정상)으로 설정
            both_eye = 0   # both_eye 기본값 설정

            # 감지된 객체 중 'eye' 클래스 찾기
            if result.boxes is not None and result.names is not None and result.probs is not None:
                for box, name, prob in zip(result.boxes, result.names, result.probs):
                    if name == "eye":
                        both_eye = prob  # 눈 감지 확률
                        if both_eye < user_state["eye_THRESH"]:
                            user_state["COUNTER"] += 1
                            if user_state["COUNTER"] >= user_state["eye_CONSEC_FRAMES"]:
                                if not user_state["TIMER_FLAG"]:
                                    user_state["start_closing"] = timeit.default_timer()
                                    user_state["TIMER_FLAG"] = True
                                status = '1'
                        else:
                            status = '0'
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

            # 화면에 상태 출력
            cv2.putText(frame, f"Status : {status}, both_eye : {both_eye:.2f}", (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255) if status == '1' else (0, 255, 0), 2)

            # 상태 업데이트 및 데이터베이스 기록
            current_time = time.time()
            if current_time - user_state["last_update_time"] >= 2:  # 2초마다 상태 업데이트
                if 1 <= user_no <= 4:
                    # 모든 상태값을 NULL로 초기화
                    st_values = [None, None, None, None]
                    # 얼굴 인식 번호에 따라 해당 인덱스의 상태값을 업데이트
                    st_values[user_no - 1] = status
                    dt = datetime.fromtimestamp(current_time)
                    current_timestamp = dt.strftime('%Y-%m-%d %H:%M:%S')
                    query = f"INSERT INTO Tester1(st1, st2, st3, st4, timestamp) VALUES (%s, %s, %s, %s, %s)"
                    val = (*st_values, current_timestamp)
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