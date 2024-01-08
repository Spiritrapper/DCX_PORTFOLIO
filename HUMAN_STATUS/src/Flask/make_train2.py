from flask import Flask, render_template, Response
import numpy as np
import cv2
import imutils
import dlib
from imutils import face_utils
from imutils.video import VideoStream
from threading import Thread
from scipy.spatial import distance as dist
import mysql.connector
import time
import os
import timeit
from sqlalchemy import text
from flask_cors import CORS

template_dir = os.path.abspath('src/main/resources/templates')

app = Flask(__name__, template_folder=template_dir)
CORS(app) 

detector = dlib.get_frontal_face_detector()
#predictor = dlib.shape_predictor("C:\eGovFrame-4.0.0\workspace.edu\Z_Project4\src\Flask\project\shape_predictor_68_face_landmarks.dat")
predictor_path = r"C:\eGovFrame-4.0.0\workspace.edu\Z_Project4\src\Flask\project\shape_predictor_68_face_landmarks.dat"
predictor = dlib.shape_predictor(predictor_path)
(lStart, lEnd) = face_utils.FACIAL_LANDMARKS_IDXS["left_eye"]
(rStart, rEnd) = face_utils.FACIAL_LANDMARKS_IDXS["right_eye"]


time.sleep(1.0)

db = mysql.connector.connect(
    host="project-db-campus.smhrd.com",
    port=3312,
    user="seocho_22K_DCX_final_2",
    password="smhrd2",
    database="seocho_22K_DCX_final_2"
)

cursor = db.cursor()
# 글로벌 변수 정의
both_eye = 0

OPEN_eye = 0
eye_THRESH = 0.35
eye_CONSEC_FRAMES = 15
COUNTER = 0
TIMER_FLAG = False
start_normal = None
normal_duration = None

def eye_aspect_ratio(eye):
    A = dist.euclidean(eye[1], eye[5])
    B = dist.euclidean(eye[2], eye[4])
    C = dist.euclidean(eye[0], eye[3])
    eye = (A + B) / (2.0 * C)
    return eye 
        # ... [eye_aspect_ratio 함수 구현을 여기에 포함합니다] ...

def light_removing(frame):
    try:
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    except Exception as e:
        print(f"Error converting frame to grayscale: {e}")
        return None, None
 
    lab = cv2.cvtColor(frame, cv2.COLOR_BGR2LAB)
    L = lab[:,:,0]
    med_L = cv2.medianBlur(L,99) #median filter
    invert_L = cv2.bitwise_not(med_L) #invert lightness
    composed = cv2.addWeighted(gray, 0.75, invert_L, 0.25, 0)
    return L, composed    # ... [light_removing 함수 구현을 여기에 포함합니다] ...

def init_open_eye():
    time.sleep(5)
    print("open init time sleep")
    eye_list = []
    for i in range(7):
        eye_list.append(both_eye)
        time.sleep(1)
    global OPEN_eye
    OPEN_eye = sum(eye_list) / len(eye_list)
    print("OPEN_eye =", OPEN_eye)   # ... [init_open_eye 함수 구현을 여기에 포함합니다] ...

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
    print("The last eye_THRESH's value :",eye_THRESH)    # ... [init_close_eye 함수 구현을 여기에 포함합니다] ...

def start_thread(func):
    # 새로운 스레드를 시작하는 함수입니다.
    thread = Thread(target=func)
    thread.daemon = True
    thread.start()
    return thread

def generate_frames():
    vs = VideoStream(src=0).start()
    global COUNTER, OPEN_eye, eye_THRESH, TIMER_FLAG, start_normal, normal_duration
    while True:
        try:

            frame = vs.read()
            if frame is None or not isinstance(frame, np.ndarray):
                print("Error reading frame from video stream")
                continue  # 다음 프레임으로 건너뜁니다.


            print("Frame read")  # 로그: 프레임 읽기 성공
            
            # 프레임 변환 (예시)
            frame = imutils.resize(frame, width=450)
            print("Frame resized")  # 로그: 프레임 크기 조정 완료
            
            # 프레임을 클라이언트로 스트리밍
            ret, buffer = cv2.imencode('.jpg', frame)
            if not ret:
                print("Failed to encode frame")
                continue

            frame = buffer.tobytes()

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
                            query = text("INSERT INTO t_user_sleep(sleep_time, nomal_time) VALUES (:sleep_time, :nomal_time)")
                            val = {'sleep_time': sleep_duration, 'nomal_time': normal_duration}
                        
                        #if sleep_duration >= 5 and normal_duration:
                            #query = text("INSERT INTO t_user_realtime(sangtae) VALUES (:status, :status)")
                            #val = {sleep_duration, normal_duration}
                            #uery = "INSERT INTO t_user_sleep(sleep_time, nomal_time) VALUES (%s, %s)"
                            #val = (sleep_duration, normal_duration)
                            cursor.execute(query, val)
                            db.commit()
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

                # query = "INSERT INTO t_user_realtime(sangtae) VALUES (%s)"
                    #val = (status,)
                    query = text("INSERT INTO t_user_realtime(sangtae) VALUES (:status)")
                    val = {'status': status}
                    cursor.execute(query, val)
                    db.commit()
                    last_update_time = current_time        
                # ... [얼굴 인식 및 눈 감음 상태 처리 로직을 여기에 포함합니다] ...
                
            # 이미지 전송
            ret, jpeg = cv2.imencode('.jpg', frame)
            if not ret:
                print("Failed to encode frame")
                continue
            frame_bytes = jpeg.tobytes()

            yield (b'--frame\r\n'
                b'Content-Type: image/jpeg\r\n\r\n' + frame_bytes + b'\r\n')
        except Exception as e:
                print(f"Error processing frame: {e}")
                break  # 또는 다른 예외 처리 로직



@app.route('/')
def index():
    return render_template('index.html')

@app.route('/video_feed')
def video_feed():
    return Response(generate_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

if __name__ == '__main__':
    th_open = Thread(target=init_open_eye)
    th_open.daemon = True
    th_open.start()

    th_close = Thread(target=init_close_eye)
    th_close.daemon = True
    th_close.start()

    try:
        app.run(host='0.0.0.0', port=5008, debug=True, threaded=True, use_reloader=True)
    finally:
        vs.stop()  # Stop the video stream when the app is closing down
        cv2.destroyAllWindows()  # Destroy all OpenCV windows when the app is closing down
