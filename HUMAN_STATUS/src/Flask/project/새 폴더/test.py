from flask import Flask, jsonify
from flask import request
from flask import redirect
import torch
from my_model_module import MyModel  # 이 부분을 모델을 정의한 모듈로 변경


app = Flask(__name__)

# 모델 경로
model_path = 'path/to/save/model.pth'

# 모델 불러오기
def load_model():
    model = MyModel()  # 모델을 정의한 클래스로 변경
    model.load_state_dict(torch.load(model_path))
    model.eval()
    return model

# Flask 라우트
@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Flask 서버에서 전송한 JSON 데이터를 가져옴
        json_data = request.json
        # 모델 불러오기
        model = load_model()
        # 예측 수행
        output = model(json_data)
        # 예측 결과를 JSON 형태로 응답
        return jsonify({"prediction": output})
    except Exception as e:
        # 오류가 발생하면 오류 메시지를 응답
        return jsonify({"error": str(e)})

if __name__ == '__main__':
    app.run(debug=True)
# 1. 코드 실행 후 첫 페이지
# action= : 경로 설정(Flask로 보낼 때의 경로)
# method= : GET, POST 설정
@app.route('/')
def index():
    # html은 일반적으로 파이썬에서 작성하지 않고 이클립스에서 작성함!(아래코드는 예시로 작성한 것)
    html = '''
        <html>
            <title>Flask를 활용한 웹 페이지 실행</title>
            <body>
                <h1>데이터 전송</h1>
                
                <!-- <form action="test" method="GET"> -->
                <form action="test" method="GET">
                    <input type="text" name="data">
                    <input type="submit" value="전송">
                </form>
                
                
            </body>
        </html>
    '''
    return html

# 2. 전송 버튼 클릭 후의 페이지
@app.route('/test', methods=['GET','POST'])
def getData():
    
    if request.method == 'GET':
        data = request.args['data']   # ['data']는 type="text" name="data" 에서 name에 정의된 값
        print(data)
        return data
    
    else:
        data = request.form['data']
        return data       

# @app.route('/test1')
# def gonaver():
     
#     url = 'https://www.naver.com'
#     print(url)
#     return redirect(url)
    

if __name__ == '__main__':
    app.run(host='127.0.0.1', port='5001', debug=True) 