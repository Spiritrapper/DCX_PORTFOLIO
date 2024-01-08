from flask import Flask, render_template, Response
import threading
import numpy as np
import cv2
import imutils
from imutils.video import VideoStream
import threading
from flask_sqlalchemy import SQLAlchemy
import mysql.connector
import dlib
from imutils import face_utils
from scipy.spatial import distance as dist
import timeit
import dlib
import matplotlib.pyplot as plt
import sqlite3
import datetime
import time
from datetime import datetime
from scipy.spatial import distance as dist
from threading import Thread
from threading import Timer
from sqlalchemy.orm import scoped_session, sessionmaker
from video_stream import create_session, generate_frames

app = Flask(__name__)
app.register_blueprint(video_stream_blueprint)


both_eye = 0

# MySQL 데이터베이스 연결

with app.app_context():
# MySQL 데이터베이스 연결
    db = mysql.connector.connect(
        host="project-db-campus.smhrd.com",
        port=3312,
        user="seocho_22K_DCX_final_2",
        password="smhrd2",
        database="seocho_22K_DCX_final_2"
    )

    # Flask SQLAlchemy 설정
    app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://seocho_22K_DCX_final_2:smhrd2@project-db-campus.smhrd.com:3312/seocho_22K_DCX_final_2'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    db = SQLAlchemy(app)

    session = scoped_session(sessionmaker(autocommit=False,
                                        autoflush=False,
                                        bind=db.engine,  # 'get_engine(app)' 대신 'engine' 속성 사용
                                        expire_on_commit=False))
# Flask SQLAlchemy 설정


# ... (define your models)



# ... (other functions)
class UserRealtime(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    sangtae = db.Column(db.String(255))

# ... Other database models go here
def create_session():
    with app.app_context():
        return scoped_session(sessionmaker(autocommit=False,
                                          autoflush=False,
                                          bind=db.engine,
                                          expire_on_commit=False))
def light_removing(frame) :
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    lab = cv2.cvtColor(frame, cv2.COLOR_BGR2LAB)
    L = lab[:,:,0]
    med_L = cv2.medianBlur(L,99) #median filter
    invert_L = cv2.bitwise_not(med_L) #invert lightness
    composed = cv2.addWeighted(gray, 0.75, invert_L, 0.25, 0)
    return L, composed

def init_open_eye():

    global both_eye
    global db
    global session

    time.sleep(5)
    print("open init time sleep")
    eye_list = []
    for i in range(7):
        eye_list.append(both_eye)
        time.sleep(1)
    global OPEN_eye
    OPEN_eye = sum(eye_list) / len(eye_list)
    print("OPEN_eye =", OPEN_eye)

def init_close_eye():
    time.sleep(7)  # 'init_open_eye' 함수 실행 시간을 고려하여 대기 시간을 7초로 설정
    print("close init time sleep")
    eye_list = []
    for i in range(7):
        eye_list.append(both_eye)
        time.sleep(1)
    CLOSE_eye = sum(eye_list) / len(eye_list)
    global eye_THRESH
    eye_THRESH = (((OPEN_eye - CLOSE_eye) / 2) + CLOSE_eye) 
    print("CLOSE_eye =", CLOSE_eye)
    print("The last eye_THRESH's value :",eye_THRESH)

def start_thread(func):
    # 새로운 스레드를 시작하는 함수입니다.
    thread = Thread(target=func)
    thread.deamon = True
    thread.start()
    return thread

def eye_aspect_ratio(eye):
    A = dist.euclidean(eye[1], eye[5])
    B = dist.euclidean(eye[2], eye[4])
    C = dist.euclidean(eye[0], eye[3])
    eye = (A + B) / (2.0 * C)
    return eye 
    
    
OPEN_eye = 0
eye_THRESH = 0.35
eye_CONSEC_FRAMES = 15
COUNTER = 0

closed_eyes_time = []
TIMER_FLAG = False
ALARM_FLAG = False

ALARM_COUNT = 0
RUNNING_TIME = 0
PREV_TERM = 0

np.random.seed(30)

test_data = []
result_data = []
prev_time = 0
print("loading facial landmark predictor...")
detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor("C:\eGovFrame-4.0.0\workspace.edu\BootMember2\src\Flask\project\shape_predictor_68_face_landmarks.dat")
(lStart, lEnd) = face_utils.FACIAL_LANDMARKS_IDXS["left_eye"]
(rStart, rEnd) = face_utils.FACIAL_LANDMARKS_IDXS["right_eye"]
print("starting video stream thread...")
vs = VideoStream(src=0).start()
time.sleep(1.0)
th_open = start_thread(init_open_eye)
time.sleep(7)  # 'init_open_eye' 함수가 완료될 때까지 대기
th_close = start_thread(init_close_eye)
start_normal = None  # 노말타임을 측정하기 위한 시작 시간 변수 추가
status_update_interval = 2  # 상태 업데이트 간격(초)
last_update_time = time.time()  # 마지막 상태 업데이트 시간
status_update_interval = 2  # 상태 업데이트 간격(초)
last_update_time = time.time()  # 마지막 상태 업데이트 시간

session = create_session()

while True:
    frame = vs.read()
    if frame is None:
        print("No frame available. Check video source.")
        break
    frame = imutils.resize(frame, width=450)
    L, gray = light_removing(frame)
    rects = detector(gray, 0)
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
        current_time = time.time()

        if both_eye < eye_THRESH:
            COUNTER += 1
            if COUNTER >= eye_CONSEC_FRAMES:
                if not TIMER_FLAG:
                    start_closing = timeit.default_timer()
                    if start_normal:  # 노말타임 측정
                        end_normal = timeit.default_timer()
                        normal_duration = end_normal - start_normal
                        start_normal = None  # 노말타임 측정 초기화
                    TIMER_FLAG = True
                cv2.putText(frame, "Status : Sleep", (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
        else:
            if TIMER_FLAG:
                end_closing = timeit.default_timer()
                sleep_duration = end_closing - start_closing
                # 5초 이상 잠잔 경우에만 DB에 잠잔 시간(초)와 노말타임(초) 저장
                if sleep_duration >= 5 and normal_duration:
                    query = "INSERT INTO t_user_sleep(sleep_time, nomal_time) VALUES (%s, %s)"
                    val = (sleep_duration, normal_duration)
                    session.execute(query, val)
                    session.commit()
                TIMER_FLAG = False
                start_normal = timeit.default_timer()  # 노말타임 측정 시작
            COUNTER = 0
            cv2.putText(frame, "Status : Normal", (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 255, 0), 2)
        cv2.putText(frame, "eye : {:.2f}".format(both_eye), (300, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (200, 30, 20), 2)

        if current_time - last_update_time >= status_update_interval:  # 2초마다 상태 업데이트
            if both_eye < eye_THRESH:
                status = 'sleep'
                cv2.putText(frame, "Status : Sleep", (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
            else:
                status = 'normal'
                cv2.putText(frame, "Status : Normal", (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 255, 0), 2)

            query = "INSERT INTO t_user_realtime(sangtae) VALUES (%s)"
            val = (status,)
            session.execute(query, val)
            session.commit()
            last_update_time = current_time
        cv2.imshow("Frame", frame)
    key = cv2.waitKey(1) & 0xFF
    if key == ord("q"):
        break

# Blueprint for video streaming logic

def index():
    with app.app_context():
     session = create_session()
    return render_template('index.html')

@app.route('/video_feed')
def video_feed():
    with app.app_context():
        session = create_session()
        return Response(generate_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

def start_thread(func):
    thread = threading.Thread(target=func)
    thread.daemon = True
    thread.start()
    return thread

if __name__ == '__main__':
    app.run('0.0.0.0',port=5008,debug=True)
