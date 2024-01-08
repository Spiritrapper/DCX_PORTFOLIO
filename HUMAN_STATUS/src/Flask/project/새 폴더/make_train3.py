from flask import Flask, Response, render_template
import cv2
import os

template_dir = os.path.abspath('src/main/resources/templates')

app = Flask(__name__, template_folder=template_dir)

def generate_frames():
    camera = cv2.VideoCapture(0)  # 0은 첫 번째 웹캠을 의미합니다.
    
    while True:
        success, frame = camera.read()  # 카메라로부터 프레임을 읽어옵니다.
        if not success:
            break
        else:
            ret, buffer = cv2.imencode('.jpg', frame)
            frame = buffer.tobytes()
            yield (b'--frame\r\n'
                   b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')
@app.route('/')
def index():
    """Video streaming home page."""
    return render_template('index.html')

@app.route('/video')
def video():
    return Response(generate_frames(), 
                    mimetype='multipart/x-mixed-replace; boundary=frame')

if __name__ == '__main__':
    app.run(debug=True)
