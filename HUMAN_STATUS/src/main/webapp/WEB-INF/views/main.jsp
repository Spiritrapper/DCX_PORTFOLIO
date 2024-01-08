<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
        <!--버블css  -->
        <link rel="stylesheet" href="assets/css/bubble.css">
        
        <!-- 애니메이트라이브러리 -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

        <!-- xsslider slider css -->


        <!--<link rel="stylesheet" href="assets/css/xsslider.css">-->




        <!--For Plugins external css-->
        <!--<link rel="stylesheet" href="assets/css/plugins.css" />-->

        <!--Theme custom css -->
        <link rel="stylesheet" href="assets/css/style.css">
        <!--<link rel="stylesheet" href="assets/css/colors/maron.css">-->

        <!--Theme Responsive css-->
        <link rel="stylesheet" href="assets/css/responsive.css" />
        
        <!-- main 로그인폰트  -->
      <link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet">
      <!-- respond js -->
        <script src="assets/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
        <!--폰트어썸 -->
        <script src="https://kit.fontawesome.com/664170947c.js" crossorigin="anonymous"></script>
        
       <style>
       .grid-container {
  display: grid;
  grid-template-columns: 1fr 1fr; /* 두 개의 컬럼을 동일한 너비로 설정합니다. */
  gap: 20px; /* 그리드 아이템 사이의 간격을 조절합니다. */
}

/* 각 섹션의 스타일을 추가합니다. */
.section1, .section2 {
  padding: 20px;
  
}
       </style>
    </head>

    <body data-spy="scroll" data-target=".navbar-collapse">
   
    <!--header include 시작  -->
    <jsp:include page="header.jsp"></jsp:include>
    <!--header include 끝  -->

 


<!-- Home Sections-->

            
            <section id="home" class="home bg-black fix">
               
               <div class="bubble-container" id="bubble-container"></div> <!-- 이곳에 버블 컨테이너 추가 -->

                
                <div class="overlay" ></div>
                
                <div class="container">
                    <div class="row">
                        <div class="main_home text-center">
                            <div class="col-md-12 ">
                                <div class="hello_slid">
                                    <div class="slid_item ">
                                        <div class="home_text ">
                                        
                                    
                                            <h2 class="text-white animate__animated animate__backInDown animate__slow">WelCome to JANI</h2>
                                            <h1 class="text-white animate__animated animate__backInLeft animate__slow" style="font-family: 'Comic Sans MS', sans-serif; ">JANI 란?</h1>
                                            
                                            
                                            
                                            <div class="grid-container">
  <div class="grid-item section1"><img src="assets/images/Learning.jpg" style="width: 600px; opacity: 0.9;"></div>
  <div class="grid-item section2"><h3 class="text-white animate__animated animate__backInUp animate__slow"><br>실시간 영상 교육<br>교육생의 <strong>졸음 및 집중여부</strong> 판단 서비스
  <br><br>
  강의별 교육생<br>
  강의 집중도 <strong>데이터 시각화</strong> 서비스
  <br><br>
  <span style="font-size: 20px; color: #A9A9A9">자세한 사용법은 우측 슬라이드를 넘겨주세요</span>
  </div>
</div>

                                            
                                        </div>
                              
                                        <div class="home_btns m-top-40">

                                        </div>
                                    </div>
                                    <div class="slid_item">
                                        <div class="home_text ">
                                                                                
                                            <h2 class="text-white wow fadeInRight" data-wow-duration='5s'"><strong>Video Chat</strong> page</h2>                        
                                            <img src="assets/images/sleep.png" style="opacity: 0.9" background-position="center" background-size="cover";>
                                            <h3 class="text-white"> <strong></strong></h3>
                                        </div>

                                        <div class="home_btns m-top-40">
                                           
                                        </div>
                                    </div>
                                    <div class="slid_item">
                                        <div class="home_text ">
                                            <h2 class="text-white wow fadeInRight" data-wow-duration='5s'"><strong>History</strong> page</h2>                        
                                            <img src="assets/images/expl_history.png" style="opacity: 0.9" background-position="center" background-size="cover";>
                                            <h3 class="text-white"> <strong></strong></h3>
                                            <!-- <a href="/bigdata/login" class="mainbtn red animate__animated animate__pulse animate__infinite">login Go</a> -->
                                        </div>

                                       
                                            
                                            
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>


                    </div>
                </div>
            </section>

                
                
            <!-- footer 인클루드 부분 시작 -->
            <jsp:include page="footer.jsp"></jsp:include>
            <!-- footer 인클루드 부분 종료 -->
            <!-- 페이지 연결을 위한 코드 끝 -->     
            

        


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

      <!--버블js  -->
      <script src="assets/js/bubble.js"></script>
        
        <script src="assets/js/plugins.js"></script>
        <script src="assets/js/main.js"></script>

    </body>
</html>