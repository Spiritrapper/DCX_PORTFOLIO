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
        <title>Q&A Write</title>
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
       
        
        <!-- 애니메이트라이브러리 -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

        <!-- xsslider slider css -->


        <!--<link rel="stylesheet" href="assets/css/xsslider.css">-->




        <!--For Plugins external css-->
        <!--<link rel="stylesheet" href="assets/css/plugins.css" />-->

        <!--Theme custom css -->
        <link rel="stylesheet" href="assets/css/style_board.css">
        <link rel="stylesheet" href="assets/css/style_write.css">
        <!--<link rel="stylesheet" href="assets/css/colors/maron.css">-->

        <!--Theme Responsive css-->
        <link rel="stylesheet" href="assets/css/responsive.css" />
        
        <!-- main 로그인폰트  -->
      <link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet">
      <!-- respond js -->
        <script src="assets/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
        <!--폰트어썸 -->
        <script src="https://kit.fontawesome.com/664170947c.js" crossorigin="anonymous"></script>
     

     
        
    </head>
   
   
   
   <body data-spy="scroll" data-target=".navbar-collapse">
   
    <!--header include 시작  -->
    <jsp:include page="header.jsp"></jsp:include>
    <!--header include 끝  -->
    
    
    <section id="home" class="home bg-black fix">
               
              

                
<!--                 <div class="overlay" ></div> -->
                
                <div class="container">
                    <div class="row">
                        <div class="main_home text-center">
                            <div class="col-md-12 ">
    
                        <div class="layout">
                        <form action="${pageContext.request.contextPath}/boardform" method="post" class="board_write"> 
                        <div class="board_J"align="center">게시판 글쓰기</div>
                        
                        <label for="title" class="col-sm-2 col-form-label fw-bolder">
                        제목</label>
                        <!-- 게시판 제목 -->
                        <input name="board_title" type="text" placeholder="제목을 입력하세요" 
                        style="max-width: 800px; float: left; margin-Bottom: 30px">
                        
                        <!-- 게시판 내용 -->
                        <label for="content" class="col-sm-2 col-form-label fw-bolder">내용</label>
                        <textarea name="board_content" rows="15"
                      placeholder="내용을 입력하세요"></textarea>
                           
                          
                           <div align="center" style="margin: 50px 50px 30px 50px">
               
                           <button type="submit" class="custom-btn btn-7"><span>작성</span></button>
                           
                           <a href="/bigdata/board" type="button"
                      class="custom-btn btn-12"><span>Q&A로</span><span>돌아가기</span></a>
                           </div>
                           
                        </form>
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
            
         </div>
        


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

      
        
        <script src="assets/js/plugins.js"></script>
        <script src="assets/js/main.js"></script>
         
         
               
   </body>
   </html>