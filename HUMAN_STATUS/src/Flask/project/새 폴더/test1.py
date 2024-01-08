from flask import Flask, jsonify
from flask import request
from flask import redirect
from flask import render_template
import os
import cv2
import torch
import matplotlib.pyplot as plt
#from my_model_module import MyModel  # 이 부분을 모델을 정의한 모듈로 변경


app = Flask(__name__, template_folder='C:\\eGovFrame-4.0.0\\workspace.edu\\BootMember2\\src\\main\\webapp\\WEB-INF\\views')


@app.route('/')
def index():
    return render_template('main.jsp')

@app.route('/process_image', methods=['POST'])
def process_image():
    try:
        # 이미지를 업로드한 폼 필드의 이름을 확인
        file = request.files['image']
        
        # 이미지를 저장할 경로 설정 (임시 디렉토리에 저장)
        upload_path = 'uploads/'
        if not os.path.exists(upload_path):
            os.makedirs(upload_path)

        # 이미지를 업로드한 경로에 저장
        file_path = os.path.join(upload_path, file.filename)
        file.save(file_path)

        # OpenCV를 사용하여 이미지 읽기
        img = cv2.imread(file_path, cv2.IMREAD_GRAYSCALE)
        
        # 이미지를 Matplotlib을 사용하여 플로팅
        plt.imshow(img, cmap='gray')
        plt.title('Uploaded Image')
        plt.show()

        return 'Image processed successfully!'
    except Exception as e:
        return f'Error processing image: {str(e)}'


if __name__ == '__main__':
    app.run(host='127.0.0.1', port='5002', debug=True) 