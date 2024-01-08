<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
<%@ page import="java.util.List" %>
<%@ page import="com.smhrd.bigdata.entity.Vcon" %>  
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	if (session.getAttribute("loginMember") == null) {
	    response.sendRedirect("login");
	}
%>

<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <title>Made One</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" type="image/png" href="favicon.ico">

        <!--Google Font link-->
        <link href="https://fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">


        <link rel="stylesheet" href="assets/css/slick/slick.css"> 
        <link rel="stylesheet" href="assets/css/slick/slick-theme.css">
        <link rel="stylesheet" href="assets/css/animate.css">
        <link rel="stylesheet" href="assets/css/iconfont.css">
        <link rel="stylesheet" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="assets/css/bootstrap.css">
        <link rel="stylesheet" href="assets/css/magnific-popup.css">
        <link rel="stylesheet" href="assets/css/bootsnav.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/responsive.css" />
        
        <!-- 실시간 숫자 -->
        <link rel="stylesheet" href="assets/css/realtime.css" />
        
        
		<script src="assets/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
		
		<!-- 원형 차트 부분 -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.bundle.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css">
		
            
      <!-- ajax 사용 -->
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
      
      		<!-- 추가부분 -->
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>


	<!-- ajax 사용 -->

				        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        
        
    </head>

    <body data-spy="scroll" data-target=".navbar-collapse">
   
    <%
	List<Vcon> list3 = (List) session.getAttribute("list3");
	int n = list3.size();
	%>
	    <%
	List<Vcon> list4 = (List) session.getAttribute("list4");
	int n2 = list4.size();
	%>
	

    <!--header include 시작  -->
    <jsp:include page="header.jsp"></jsp:include>


      
         <section id="home" class="fix">

                                      
                <div class="wrap">
                   
                <div class="login_grid">
<!-- 영상이 나오는 부분 -->
                	<div><%= list4.get(0).getStt1() %>
                	<span style="margin-right: 500px;"></span>
                	<%= list4.get(0).getStt2() %>
                	</div>
                	
                	<img class="chat" src="http://127.0.0.1:5000/video_feed" ></img>
                	
                	<div><%= list4.get(0).getStt3() %>
                	<span style="margin-right: 500px;"></span>
                	<%= list4.get(0).getStt4() %>
                	</div>
                </div>
                <div class="login_grid">현재 자는 인원수
 						
                <!-- <div class="sleep_div"></div> -->
                <div id="numsber"></div>
                                     
                </div>
           		<div class="login_grid">
           		
           		   <canvas id="eventsChart1" width="150" height="100"></canvas>
        <!--              <form id="loginForm"  action="vcon/input" method="post" >
                   
                      <label for="id">학생1 이름</label>
                      <input type="text"  id="" placeholder="학생1" name="stt1" required>     
                       <br>
                       <label for="id">학생2 이름</label>
                      <input type="text"  id="" placeholder="학생2" name="stt2" required>
                      <br>
                      <label for="id">학생3 이름</label>
                      <input type="text"  id="" placeholder="학생3" name="stt3" required>
                      <br>
                      <label for="id">학생4 이름</label>
                      <input type="text"  id="" placeholder="학생4" name="stt4" required>  
                      <br><br>
                      <input class="join_submit " type="submit" value="학생이름변경">     
                   </form> -->
                
                
                </div>
                
                <div class="login_grid">시간별 자는 인원 수
                	<canvas id="eventsChart" width="300px" height="100px"></canvas>
                </div>
                                        
                       

                </div>
         </section>


        </div>
        
             <!-- footer 인클루드 부분 시작 -->
            <jsp:include page="footer.jsp"></jsp:include>





    <script>
    

    	let sleep_number = 0;
		
    
    <!--실시간차트  -->
    // 실시간 차트를 관리하는 스크립트

		var currentDate = new Date().toLocaleDateString('en-US');  // 오늘 날짜
		var currentTime = new Date().toLocaleTimeString('en-US', { hour12: false }); // 현재 시간
		var currentDateTime = currentDate + ' ' + currentTime; // 현재 날짜와 시간
		console.log("현재 날짜시간:" + currentDateTime); // 날짜시간 출력

		// 문자열에서 "."을 "-"로 대체하여 원하는 형식으로 변환
		let currentDateTime2 = currentDateTime.split('/').join('-');
		console.log(currentDateTime2); // 변환된 결과 출력
		// 문자열을 공백을 기준으로 분할하여 배열로 만듭니다.
		let parts = currentDateTime2.split(' ');
		// 날짜 부분을 '-'로 분할하여 배열로 만듭니다.
		let dateParts = parts[0].split('-');
		// '년-월-일' 형식으로 재구성.
		let formattedDate = dateParts[2] + '-' + dateParts[0] + '-' + dateParts[1];
		// 최종적으로 원하는 형식으로 재조합
		let formattedDateTime = formattedDate + ' ' + parts[1];
		console.log("최종변화 :",formattedDateTime); 
		
/* 		
		//추가적으로 숫자형으로 전환하는 작업
		var numericDateTime = formattedDateTime.replace(/[^\d]/g, '');
		console.log(parseInt(numericDateTime)); // 숫자형으로 변환하여 출력
     */	
    	
     var eventsChart1; // 글로벌 차트 변수

     function updateData2() {
         $.ajax({
             url: "bigdata/vcon2",
             type: "GET",
             dataType: "json",
             success: function(data) {
                 // 데이터를 HTML 요소에 추가하는 로직
                 $("#events1").empty(); // 이전 데이터 삭제
                 data.forEach(function(event) {
						
                     $("#events1").append("<p>student: " + event.student + ", Yawning Count: " + event.yawning_count + ", Stretching Count: " + event.stretching_count + "</p>");
                 });
                 
                 var labels = data.map(function(event) { return '학생' + event.student; });
                 var yawningData = data.map(function(event) { return event.yawning_count; });
                 var stretchingData = data.map(function(event) { return event.stretching_count; });

                 if (!eventsChart1) {
                     // 차트가 아직 초기화되지 않았다면, 초기화한다.
                     var ctx1 = document.getElementById('eventsChart1').getContext('2d');
                     eventsChart1 = new Chart(ctx1, {
                         type: 'bar',
                         data: {
                             labels: labels,
                             datasets: [{
           
                                 label: '하품 카운트',
                                 data: yawningData,
                                 backgroundColor: 'rgba(255, 99, 132, 0.2)',
                                 borderColor: 'rgba(255, 99, 132, 1)',
                                 borderWidth: 1
                             },
                             {
                                 label: '딴짓중 카운트',
                                 data: stretchingData,
                                 backgroundColor: 'rgba(54, 162, 235, 0.2)',
                                 borderColor: 'rgba(54, 162, 235, 1)',
                                 borderWidth: 1
                             }]
                         },
                         options: {
                             scales: {
                            	  yAxes: [{
                                      ticks: {
                                          beginAtZero: true,
                                          min: 0.0, // Y축 최소값
                                       
                                          stepSize: 1.0 // 눈금 간격
                                      }
                                  }]
                             }
                         }
                     });
                 } else {
                     // 차트가 이미 초기화되었다면, 데이터만 업데이트한다.
                     eventsChart1.data.labels = labels;
                     eventsChart1.data.datasets[0].data = yawningData;
                     eventsChart1.data.datasets[1].data = stretchingData;
                     eventsChart1.update();
                 }
             }
         });
     }

     $(document).ready(function() {
         updateData2(); // 최초 실행
         setInterval(updateData2, 2000); // 6초마다 반복 실행
     });
     
     


    	
    	var eventsChart; // 글로벌 차트 변수
       // 데이터를 업데이트하는 함수 정의
       function updateData() {
           // AJAX를 사용하여 서버에서 데이터 가져오기
           $.ajax({
               url: "bigdata/vcon", // 데이터를 가져올 엔드포인트 URL
               type: "GET", // GET 요청 방식 사용
               dataType: "json", // JSON 데이터 형식으로 응답 받음
               success: function(data) {
                   // 가져온 데이터를 HTML 요소에 추가하는 로직
                   
                   $("#events").empty(); // 이전 데이터 삭제
                   data.forEach(function(event) {
                       // 데이터를 HTML에 추가 (Region, Yawning Count, st3)
                       $("#events").append("<p>st1: " + event.st1 + ", st2: " + event.st2 + ", st3: " + event.st3 
                    		   + ", st4: " + event.st4
                    		   + ", stamptime: " + event.stamptime
                    		   + ", stamptime2: " + event.stamptime2
                    		   
                    		   +"</p>");
                   });
                   
                   
                   // 차트를 그리기 위한 데이터 준비
                   var labels = data.map(function(event) { return event.timestamp2.substring(10); });
                   var sleep_cnt = data.map(function(event) { return event.st1 + event.st2 + event.st3 + event.st4; });
                   sleep_cnt = sleep_cnt.slice(<%= n %>);
                   labels = labels.slice(<%= n %>);
                   sleep_number = sleep_cnt[sleep_cnt.length - 1]
                   console.log(sleep_cnt)
                   console.log(sleep_number)
////                  
           		var time_de = data.map(function(event) { return event.timestamp2; });
                console.log("판단시간: " + time_de);
                console.log("labels: " + labels);


 
////				   
				   
                   

                   if (!eventsChart) {
                       // 차트가 아직 초기화되지 않았다면, 초기화한다.
                       var ctx = document.getElementById('eventsChart').getContext('2d');
                       eventsChart = new Chart(ctx, {
                           type: 'line', // 바 차트로 설정
                           data: {
                               labels: labels, // X 축 레이블 설정
                               datasets: [{
                                   label: '자는 인원 수', // 데이터셋 1 제목
                                   data: sleep_cnt, // 데이터셋 1의 값
                                   backgroundColor: 'rgba(255, 99, 132, 0.2)', // 바 색상 및 투명도
                                   borderColor: 'rgba(255, 99, 132, 1)', // 바 테두리 색상
                                   borderWidth: 1 // 바 테두리 두께
                               },
                               ]
                           },
                           options: {
                               scales: {
                            	   yAxes: [{
                                       ticks: {
                                           beginAtZero: true,
                                           min: 0.0, // Y축 최소값
                                           max: 4.0, // Y축 최대값
                                           stepSize: 1.0 // 눈금 간격
                                       }
                                   }]
                               }
                           }
                       });
                   } else {
                       // 차트가 이미 초기화되었다면, 데이터만 업데이트한다.
                       eventsChart.data.labels = labels; // 레이블 업데이트
                       eventsChart.data.datasets[0].data = sleep_cnt; // 데이터셋 1 업데이트
                       
                       eventsChart.update(); // 차트 업데이트
                   }
               }
           });
       }
    	
       function setInnerHTML() {
    	    var sleepDiv = document.querySelector('.sleep_div');
    	    if (sleepDiv) {
    	        sleepDiv.innerHTML = sleep_number; // 여기에 내용을 추가하십시오
    	    } else {
    	        console.error('클래스가 "sleep_img_div"인 div를 찾을 수 없습니다.');
    	    }
    	}

       // 문서가 준비되면 함수 실행
       $(document).ready(function() {
           updateData(); // 최초 실행
           setInnerHTML();
           setInterval(updateData, 2000); // 6초마다 반복 실행
           setInterval(setInnerHTML, 2000); // 6초마다 반복 실행
       });



      
    
    </script>
   
   
   <!-- script 부분 시작------------------------------------------------------------------------------ -->
   
           <!-- JS includes -->

        <script src="assets/js/vendor/jquery-1.11.2.min.js"></script>
        <script src="assets/js/vendor/bootstrap.min.js"></script>

        <script src="assets/js/owl.carousel.min.js"></script>
        <script src="assets/js/jquery.magnific-popup.js"></script>
        <script src="assets/js/jquery.easing.1.3.js"></script>
        <script src="assets/css/slick/slick.js"></script>
        <script src="assets/css/slick/slick.min.js"></script>
        <script src="assets/js/jquery.collapse.js"></script>
        <script src="assets/js/bootsnav.js"></script>
        
        
        <!-- 실시간 -->
        <script src="assets/js/realtime.js"></script>



        <script src="assets/js/plugins.js"></script>
        <script src="assets/js/main.js"></script>
        


    </body>
</html>