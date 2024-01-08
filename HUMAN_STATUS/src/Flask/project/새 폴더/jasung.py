import cv2
import dlib
from scipy.spatial import distance
import numpy as np
import imutils
import time
import timeit
import dlib
import cv2
import matplotlib.pyplot as plt
import mysql.connector
import sqlite3
import datetime
import time
import mysql.connector
from datetime import datetime
from scipy.spatial import distance as dist
from imutils.video import VideoStream
from imutils import face_utils
from threading import Thread
from threading import Timer
import time
from sqlalchemy import text

# 눈 감김 여부를 판단하는 함수
def eye_aspect_ratio(eye):
    A = distance.euclidean(eye[1], eye[5])
    B = distance.euclidean(eye[2], eye[4])
    C = distance.euclidean(eye[0], eye[3])
    ear = (A + B) / (2.0 * C)
    return ear

# dlib의 얼굴 탐지기 및 랜드마크 예측기 초기화
detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor("C:\eGovFrame-4.0.0\workspace.edu\Z_Project5\src\Flask\project\shape_predictor_68_face_landmarks.dat")

# 졸음 감지를 위한 임계값 설정
EAR_THRESHOLD = 0.25
CONSECUTIVE_FRAMES = 20

# 눈 깜빡임 횟수 초기화
frame_counter = 0
blink_counter = 0

# 웹캠 초기화
cap = cv2.VideoCapture(0)

while True:
    ret, frame = cap.read()

    # 얼굴 검출
    faces = detector(frame)
    for face in faces:
        # 랜드마크 예측
        shape = predictor(frame, face)
        #shape = shape_to_np(shape)

        # 양쪽 눈의 좌표 추출
        left_eye = shape[42:48]
        right_eye = shape[36:42]

        # 눈 감김 비율 계산
        left_ear = eye_aspect_ratio(left_eye)
        right_ear = eye_aspect_ratio(right_eye)
        ear = (left_ear + right_ear) / 2.0

        # 눈 감김 여부 확인
        if ear < EAR_THRESHOLD:
            frame_counter += 1
        else:
            if frame_counter >= CONSECUTIVE_FRAMES:
                blink_counter += 1
            frame_counter = 0

    # 결과 출력
    cv2.putText(frame, f"Blinks: {blink_counter}", (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 255, 0), 2)

    # 화면 표시
    cv2.imshow("Drowsiness Detection", frame)

    # 종료 조건
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# 리소스 해제
cap.release()
cv2.destroyAllWindows()