from flask import Flask, render_template, Response
import numpy as np
import cv2
print(cv2.__version__)
import imutils
from imutils.video import VideoStream
import threading
from flask_sqlalchemy import SQLAlchemy
import dlib
from imutils import face_utils
from scipy.spatial import distance as dist
import timeit
import os
from threading import Thread
import time
from sqlalchemy.orm import scoped_session, sessionmaker
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # CORS 설정

def create_session():
    with app.app_context():
        return scoped_session(sessionmaker(autocommit=False,
                                          autoflush=False,
                                          bind=db.engine,
                                          expire_on_commit=False))




template_folder_path = os.path.join(os.getcwd(), 'C:\eGovFrame-4.0.0\workspace.edu\Z_Project4\src\main\webapp\WEB-INF\views\vcon.jsp')
app = Flask(__name__, template_folder=template_folder_path)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://seocho_22K_DCX_final_2:smhrd2@project-db-campus.smhrd.com:3312/seocho_22K_DCX_final_2'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

def create_session():
    with app.app_context():
        return scoped_session(sessionmaker(autocommit=False, autoflush=False, bind=db.engine, expire_on_commit=False))

class UserRealtime(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    sangtae = db.Column(db.String(255))

# 글로벌 변수 정의
both_eye = 0
OPEN_eye = 0
eye_THRESH = 0.35
eye_CONSEC_FRAMES = 15


def generate_frames():
    with app.app_context():
        # 라우트 내부에서 호출되는 함수 내에서 create_session 사용
        session = create_session()

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
vs = VideoStream(src=0, apiPreference=cv2.CAP_DSHOW).start()
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

def generate_frames():
    global vs, both_eye, OPEN_eye, eye_THRESH 

     # vs를 전역 변수로 선언하여 다른 함수에서도 접근할 수 있게 합니다.

    while True:
        try:
            frame = vs.read()
            if frame is None:
                print("No frame available. Check video source.")
                raise ValueError("No frame available. Check video source.") 

            frame = imutils.resize(frame, width=450)
            gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
            rects = detector(gray, 0)

            for rect in rects:
                shape = predictor(gray, rect)
                shape = face_utils.shape_to_np(shape)
                leftEye = shape[lStart:lEnd]
                rightEye = shape[rStart:rEnd]
                leftEAR = eye_aspect_ratio(leftEye)
                rightEAR = eye_aspect_ratio(rightEye)
                both_eye = (leftEAR + rightEAR) * 500

                # 데이터베이스에 눈 상태 저장
                if both_eye < eye_THRESH:
                    # 데이터베이스에 'sleep' 상태 저장
                    new_status = UserRealtime(sangtae='sleep')
                    db.session.add(new_status)
                else:
                    # 데이터베이스에 'awake' 상태 저장
                    new_status = UserRealtime(sangtae='awake')
                    db.session.add(new_status)

                db.session.commit()
        except Exception as e:
            print(f"An error occurred: {e}")  # 예외가 발생했을 때 콘솔에 출력합니다.
            break  # 오

        # 이미지 전송
        ret, jpeg = cv2.imencode('.jpg', frame)
        frame_bytes = jpeg.tobytes()
        yield (b'--frame\r\n'
               b'Content-Type: image/jpeg\r\n\r\n' + frame_bytes + b'\r\n\r\n')

    vs.stop()  # 비디오 스트림을 명시적으로 정지합니다.
    cv2.destroyAllWindows() 
        
@app.route('/')
def index():
    return render_template('index.html')

# @app.route('/')
# def index():
#     with app.app_context():
#         session = create_session()
#     return render_template('index.html')

@app.route('/video_feed')
def video_feed():
    return Response(generate_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

if __name__ == '__main__':
    try:
        app.run('0.0.0.0', port=5008, debug=True)
    finally:
        vs.stop()  # 웹 서버 종료 시 비디오 스트림을 정지합니다.
        cv2.destroyAllWindows()  