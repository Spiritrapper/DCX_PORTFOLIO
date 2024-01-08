from flask import Flask, render_template, request, redirect, url_for
import subprocess

app = Flask(__name__,  template_folder='C:\\eGovFrame-4.0.0\\workspace.edu\\BootMember2\\src\\main\\webapp\\WEB-INF\\views')

@app.route('/')
def index():
    print("1")
    return render_template('main.jsp')

@app.route('/run_deep_learning', methods=['POST'])
def run_deep_learning():
    print("1")
    try:
        # 딥러닝 모델 실행 또는 필요한 처리
        subprocess.run(['python', 'deep.py'])

        # 결과값을 Flask에서 Spring Boot으로 전송
        result = "Your result from deep learning"
        return redirect(url_for('send_to_spring_boot', result=result))
    except Exception as e:
        return f"Error: {str(e)}"
    
@app.route('/send_to_spring_boot')
def send_to_spring_boot():
    print("1")


if __name__ == '__main__':
    app.run(host='127.0.0.1', port='5004', debug=True)