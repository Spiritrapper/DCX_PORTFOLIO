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
import hashlib

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
#predictor = dlib.shape_predictor("C:\eGovFrame-4.0.0\workspace.edu\Z_Project5\src\Flask\project\shape_predictor_68_face_landmarks.dat")
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

def stable_hash(face_id):
    hasher = hashlib.sha256()
    hasher.update(str(face_id).encode('utf-8'))
    return hasher.hexdigest()

# 사용자 상태 초기화 함수
def init_user_state():
    return {"OPEN_eye": 0, "eye_THRESH": 200, "eye_CONSEC_FRAMES": 3, 
            "COUNTER": 0, "TIMER_FLAG": False, "both_eye": 0, 
            "normal_duration": 0, "last_update_time": time.time()}


# def combine_frames(frames, screen_width, screen_height):
#     # 네 개의 프레임을 하나의 화면에 병합
#     top_half = np.hstack((frames[0], frames[1]))
#     bottom_half = np.hstack((frames[2], frames[3]))
#     combined_frame = np.vstack((top_half, bottom_half))

#     # 화면 크기에 맞게 조정
#     combined_frame = cv2.resize(combined_frame, (screen_width, screen_height))
#     return combined_frame


# 네 개 또는 세 개의 프레임을 하나의 화면에 병합하는 함수
def combine_frames(frames, screen_width, screen_height):
    if len(frames) == 3:
        combined_frame = np.vstack(frames)
    elif len(frames) == 4:
        top_half = np.hstack((frames[0], frames[1]))
        bottom_half = np.hstack((frames[2], frames[3]))
        combined_frame = np.vstack((top_half, bottom_half))
    else:
        raise ValueError("Unsupported number of frames to combine.")
    combined_frame = cv2.resize(combined_frame, (screen_width, screen_height))
    return combined_frame

# 사용자 상태 딕셔너리 초기화
user_states = {}
status_update_interval = 2  # 2초로 설정


# 화면을 4등분하는 구역을 정의



# 4등분할 구역 정의
regions_4 = [
    (0, 0, 800, 500),
    (800, 0, 800, 500),
    (0, 500, 800, 500),
    (800, 500, 800, 500)
]

# 3등분할 구역 정의
regions_3 = [
     (0, 0, 800, 500),
    (800, 0, 800, 500),
    (0, 500, 1600, 500)
]
# 화면 캡처 및 이미지 처리를 위한 함수
# 화면 캡처 및 이미지 처리를 위한 함수

        # Dlib 얼굴 감지
def is_valid_user_id(unique_user_id):
    # 양의 정수인지 확인
    if isinstance(unique_user_id, int) and unique_user_id > 0:
        # 특정 범위 내에 있는지 확인 (예: 1부터 4까지 유효한 범위)
        if 100 <= int(unique_user_id) <= 1500:
            return True
    return False

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
    current_time = time.time()
    frames = []

    # 3구역 또는 4구역 사용 선택
    use_three_regions = True  # True면 3구역, False면 4구역 사용
    regions = regions_3 if use_three_regions else regions_4

    while True:
        frames.clear()
        user_state = init_user_state() 
       # for i, region in regions:
        for region in regions:
     # both_eye 변수를 초기화
            both_eye = 0.0    

            status = '0'
        # Zoom 화면 캡처
            screenshot = pyautogui.screenshot(region=region)
            frame = np.array(screenshot)
            frame = cv2.cvtColor(frame, cv2.COLOR_RGB2BGR)

            # Dlib 얼굴 감지
            L, gray = light_removing(frame)
            rects = detector(gray, 0)

            # 감지된 얼굴 수에 따라 사용자 상태 딕셔너리를 업데이트합니다.
            # Update: Use a unique identifier for each face (e.g., rectangle coordinates)
            current_faces = set() 
            # user_state = None 

            # 각 프레임별 얼굴 감지 및 상태 업데이트 처리
            for rect in rects:
                # Convert dlib.rectangle to a hashable tuple
                face_id = (rect.left(), rect.top(), rect.right(), rect.bottom())
                current_faces.add(face_id)

                unique_user_id = stable_hash(face_id)
                if unique_user_id not in user_states:
                    user_states[unique_user_id] = init_user_state()
                # user_state = user_states[unique_user_id] 
                #     user_state = user_states.get(unique_user_id, init_user_state())
                # user_states[unique_user_id] = user_state

            # Update user_states logic accordingly
            # Remove states for faces not currently seen
            faces_to_remove = [face for face in user_states if face not in current_faces]
            for face in faces_to_remove:
                user_states.pop(face)


            for face_id in current_faces:
                if face_id not in user_states:
                    user_states[face_id] = init_user_state()
                user_state = user_states[face_id] 

                unique_user_id = stable_hash(face_id)
                rect = dlib.rectangle(*face_id)
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
                unique_user_id = stable_hash(face_id)
                query = """
                INSERT INTO face_detections (face_x1, face_y1, face_x2, face_y2, status) 
                VALUES (%s, %s, %s, %s, %s)
                """
                val = (face_id[0], face_id[1], face_id[2], face_id[3], status)
                cursor.execute(query, val)
                db.commit()

                detection_id = cursor.lastrowid


                # 사용자 상태 업데이트
                user_state = user_states.get(face_id, None)
                if user_state is not None:
                    user_state["both_eye"] = both_eye

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
                            try:
                                if sleep_duration >= 1:
                                    # 현재 face_id에 해당하는 마지막 insert ID를 얻습니다.
                                    
                                    query = "INSERT INTO T_USER_SLEEP1 (unique_user_id, sleep_status, duration) VALUES (%s, %s, %s)"
                                    val = (detection_id, status, sleep_duration) 
                                    cursor.execute(query, val)
                                    db.commit()
                            except Exception as e:
                                print("Database Error: ", e)
                            user_state["TIMER_FLAG"] = False
                        user_state["COUNTER"] = 0


            # 상태를 화면에 출력
                        
                        
            if user_state is not None and current_time - user_state["last_update_time"] >= status_update_interval:
            #if current_time - user_state["last_update_time"] >= status_update_interval:  # 2초마다 상태 업데이트
                # unique_user_id = hash(face_id)  # 예시로 해시를 사용했습니다.
                if is_valid_user_id(unique_user_id):     
                # if 1 <= unique_user_id <= 4:
                    # 모든 상태값을 NULL로 초기화
                    st_values = [None, None, None, None]
                    # 얼굴 인식 번호에 따라 해당 인덱스의 상태값을 업데이트
                    st_values[unique_user_id - 1] = status
                    dt = datetime.fromtimestamp(current_time)
                    current_timestamp = dt.strftime('%Y-%m-%d %H:%M:%S')
                    query = f"INSERT INTO Tester3 (unique_user_id, st1, st2, st3, st4, timestamp) VALUES (%s, %s, %s, %s, %s, %s)"
                    val = (detection_id, *st_values, current_timestamp)  # detection_id와 상태(st1, st2, st3, st4)를 추가
                    cursor.execute(query, val)
                    db.commit()
                user_state["last_update_time"] = current_time

            cv2.putText(frame, f"Status : {status}, both_eye : {both_eye:.2f}", (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255) if status == 'sleep' else (0, 255, 0), 2)

                    # 네 개의 프레임을 하나로 병합
            frames.append(frame) 
            
            print(frames)
        if frames:
            global_frame = combine_frames(frames, 1600, 1000)
        # global_frame = frame
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