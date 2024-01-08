from flask import Flask, Response, render_template
import threading
import cv2
import dlib
from imutils import face_utils
import numpy as np
import pyautogui
import mysql.connector
import time
import os
from scipy.spatial import distance as dist

# Flask 애플리케이션 설정
template_dir = os.path.abspath('C:/eGovFrame-4.0.0/workspace.edu/Z_Project5/src/main/resources/templates')

app = Flask(__name__, template_folder=template_dir)

# Dlib 얼굴 감지 및 눈 비율 계산 준비
detector = dlib.get_frontal_face_detector()
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

# 네 개 또는 세 개의 프레임을 하나의 화면에 병합하는 함수
def combine_frames(frames, screen_width, screen_height):
    top_half = np.hstack((frames[0], frames[1]))
    bottom_half = np.hstack((frames[2], frames[3]))
    combined_frame = np.vstack((top_half, bottom_half))
    combined_frame = cv2.resize(combined_frame, (screen_width, screen_height))
    return combined_frame

def capture_video():
    global global_frame
    regions = [
        (0, 0, 800, 500),
        (800, 0, 800, 500),
        (0, 500, 800, 500),
        (800, 500, 800, 500)
    ]

    while True:
        frames = []
        for region in regions:
            screenshot = pyautogui.screenshot(region=region)
            frame = np.array(screenshot)
            frame = cv2.cvtColor(frame, cv2.COLOR_RGB2BGR)
            # 얼굴 감지 및 기타 처리 로직
            gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
            rects = detector(gray, 0)
            for rect in rects:
                shape = predictor(gray, rect)
                shape = face_utils.shape_to_np(shape)
                # 여기에 추가 처리를 구현할 수 있습니다.
                # 예: leftEye = shape[lStart:lEnd]

            frames.append(frame)

        if frames:
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
