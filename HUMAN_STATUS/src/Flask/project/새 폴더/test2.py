from flask import Flask
from flask import request, redirect

app = Flask(__name__) 

@app.route('/addNumber', methods=['GET','POST'])
#@app.route('/', methods=['GET','POST'])
def index():     
    
    # get 요청 처리
    if request.method == 'GET':
        print('1')
        print('2')

        num1 = int(request.args['num1'])
        num2 = int(request.args['num2'])
        
        # result = model()

    # post 요청 처리
    else:
        print('num1')
        print('num2')
        num1 = int(request.form['num1'])
        num2 = int(request.form['num2'])
        print(num1 )
        print(num2 )
        # result = model()

    url = 'http://localhost:8087/bigdata/?result={}'.format(num1+num2)
 
    return redirect(url)

if __name__ == '__main__':
    app.run(host='127.0.0.1', port='5003', debug=True) 