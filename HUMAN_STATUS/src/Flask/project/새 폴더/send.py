from flask import Flask
from flask import redirect

app = Flask(__name__)

@app.route('/')
def index():     
    # JSP로 만들어진 웹 페이지에 데이터 전송
    # GET방식으로 데이터 전달 시 쿼리스트링 기술 활용
    #  -> ?name=value&name=value&...
    #url = 'http://localhost:8095/MyProject/FlaskReceiveController?data=1234'
    url = 'http://localhost:8087/bigdata/?data=1234'
    return redirect(url)

if __name__ == '__main__':
    app.run(host='127.0.0.1', port='5000', debug=True) 