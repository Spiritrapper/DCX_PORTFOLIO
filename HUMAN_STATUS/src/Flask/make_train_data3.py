import cv2
print(cv2.__version__)
import websocket

# 웹 소켓 서버의 주소
server_url = "ws://localhost:3000"

# 웹 소켓 연결
ws = websocket.WebSocketApp(server_url)

def on_message(ws, message):
    # 메시지를 받았을 때 수행할 동작을 정의합니다.
    print("Received:", message)

# 메시지를 수신할 때 호출할 콜백 함수를 등록합니다.
ws.on_message = on_message

# 연결 시작
ws.run_forever()

# FFMPEG 백엔드 사용
cv2.setPreferableBackend(cv2.CAP_FFMPEG)

# OpenCV 비디오 캡처
vs = cv2.VideoCapture(0)



while True:
    ret, frame = vs.read()
    if not ret:
        break

    # 프레임을 바이트 스트림으로 인코딩하여 웹 소켓을 통해 서버로 전송
    ret, encoded_frame = cv2.imencode(".jpg", frame)
    if ret:
        ws.send(encoded_frame.tobytes())

# 연결 종료
ws.close()
vs.release()
cv2.destroyAllWindows()