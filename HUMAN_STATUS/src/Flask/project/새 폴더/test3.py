from flask import Flask
from flask import request, redirect

app = Flask(__name__) 

@app.route('/test3', methods=['GET','POST'])
#@app.route('/', methods=['GET','POST'])
def index():     
    
    # get 요청 처리
    if request.method == 'GET':
        print('1')
        print('2')

        
        # result = model()

    # post 요청 처리
    else:
        print('num1')
        print('num2')

   
        # result = model()

    url = 'http://localhost:8087/bigdata/test4'
 
    return redirect(url)

if __name__ == '__main__':
    app.run(host='127.0.0.1', port='5003', debug=True) 