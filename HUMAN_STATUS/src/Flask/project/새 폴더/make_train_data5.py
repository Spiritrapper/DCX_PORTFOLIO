import cv2
import pygame
from pygame.locals import *

# Pygame 초기화
pygame.init()

# 화면 크기 설정
screen_width, screen_height = 800, 600
screen = pygame.display.set_mode((screen_width, screen_height))
pygame.display.set_caption("Web Video with Pygame")

# OpenCV 비디오 캡처 설정 (웹상의 실시간 영상 URL 사용)
stream_url = "http://127.0.0.1:3000"  # 실제 스트리밍 주소로 대체해야 합니다
cap = cv2.VideoCapture(stream_url)
cap.set(cv2.CAP_PROP_FPS, 20)
while True:
    for event in pygame.event.get():
        if event.type == QUIT:
            cap.release()
            pygame.quit()
            exit()

    # OpneenenCV를 사용하여 프레임 가져오기
    # OpneenenCV를 사용하여 프레임 가져오기
    # Opneen
    # enCV를 사용하여 프레임 가져오기
    ret, frame = cap.read()
    print(frame)
    if not ret:
        break

    # OpenCV의 BGR 이미지를 Pygame Surface로 변환
    frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    pygame_frame = pygame.surfarray.make_surface(frame)
    
    # 화면에 프레임 표시


    screen.blit(pygame_frame, (0, 0))
    pygame.display.flip()

# OpenCV 비디오 캡처 해제
cap.release()

# Pygame 종료
pygame.quit()