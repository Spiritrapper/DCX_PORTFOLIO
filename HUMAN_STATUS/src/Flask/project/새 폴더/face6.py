import cv2
import dlib
from imutils import face_utils
import numpy as np
import pyautogui
import time
import threading
from flask import Flask, Response, render_template
from scipy.spatial import distance as dist

# Flask 애플리케이션 설정
app = Flask(__name__)

# Dlib 얼굴 감지 및 눈 비율 계산 준비
detector = dlib.get_frontal_face_detector()
predictor_path = "path_to_shape_predictor_68_face_landmarks.dat"  # 모델 파일 경로
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
    return {"eye_THRESH": 0.25, "eye_CONSEC_FRAMES": 48, 
            "COUNTER": 0, "ALERT": False}

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
        (0, 0, 800, 500),  # 구역 1
        (800, 0, 800, 500),  # 구역 2
        (0, 500, 800, 500),  # 구역 3
        (800, 500, 800, 500)  # 구역 4
    ]
    user_states = {1: init_user_state(), 2: init_user_state(), 3: init_user_state(), 4: init_user_state()}

    while True:
        frames = []
        for i, region in enumerate(regions):
            screenshot = pyautogui.screenshot(region=region)
            frame = np.array(screenshot)
            frame = cv2.cvtColor(frame, cv2.COLOR_RGB2BGR)
            gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
            rects = detector(gray, 0)

            user_state = user_states[i + 1]
            user_state["ALERT"] = False

            for rect in rects:
                shape = predictor(gray, rect)
                shape = face_utils.shape_to_np(shape)
                leftEye = shape[lStart:lEnd]
                rightEye = shape[rStart:rEnd]
                leftEAR = eye_aspect_ratio(leftEye)
                rightEAR = eye_aspect_ratio(rightEye)
                both_ear = (leftEAR + rightEAR) / 2.0

                if both_ear < user_state["eye_THRESH"]:
                    user_state["COUNTER"] += 1
                    if user_state["COUNTER"] >= user_state["eye_CONSEC_FRAMES"]:
                        user_state["ALERT"] = True
                else:
                    user_state["COUNTER"] = 0

            # 경고 상태 표시
            if user_state["ALERT"]:
                cv2.putText(frame, "ALERT!", (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
            else:
                cv2.putText(frame, "Normal", (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 255, 0), 2)

            frames.append(frame)

        global_frame = combine_frames(frames, 1600, 1000)
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
