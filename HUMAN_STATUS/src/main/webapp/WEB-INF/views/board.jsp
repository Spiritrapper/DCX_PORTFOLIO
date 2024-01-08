<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 로그인 안되있으면 로그인창으로 이동 -->
<%
   if (session.getAttribute("loginMember") == null) {
       response.sendRedirect("login");
   }
%>


<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> 
<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8">
        <title>Q&A</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" type="image/png" href="favicon.ico">

        <!--Google Font link-->
        <link href="https://fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

		<!--게시판 링크  -->
		<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />  --%>
		<noscript><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/noscript.css" /></noscript>
		
		
		
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



        <!--Theme custom css -->
        <link rel="stylesheet" href="assets/css/style_board.css">


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

 


<!-- Home Sections-->

            
            <section id="home" class="home bg-black fix">
               
              

                
                <div class="overlay" ></div>
                
                <div class="container">
                    <div class="row">
                        <div class="main_home text-center">
                            <div  class="board_form col-md-12 ">
                               
									<table class="table table-hover table-striped text-center">
                            <thead>
                                <tr >
                                    <th class="text-center">번호</th>
                                    <th class="text-center">제목</th>
                                    <th class="text-center">글쓴이</th>
                                    <th class="text-center">작성일자</th>
                                    <!-- <th>조회수</th> -->
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="b" items="${list}">
                                    <tr>
                                        <td>${b.board_idx}</td>
                                        <td><a href="${pageContext.request.contextPath}/board/${b.board_idx}">${b.board_title}</a></td>
                                        <td>${b.id}</td>
                                        <td>${b.created_at}</td>
                                        <%-- <td>${b.board_views}</td> --%>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <!-- 글쓰기 버튼 추가 -->
                        
                                    
                                    
                                </div>
                                <div class="text-right">
                            <a href="${pageContext.request.contextPath}/boardform" class="snip1535 hover">글쓰기</a>
                        </div>
                            </div>

                        </div>


                    </div>
                </div>
            </section>





                        </div>
                    </div>
                </div>
               
                
            <!-- footer 인클루드 부분 시작 -->
            <jsp:include page="footer.jsp"></jsp:include>
            <!-- footer 인클루드 부분 종료 -->
            <!-- 페이지 연결을 위한 코드 끝 -->     
            
         </div>
        


        <!-- JS includes -->
        
        
        

        <script src="assets/js/vendor/jquery-1.11.2.min.js"></script>
        <script src="assets/js/vendor/bootstrap.min.js"></script>

        <!-- <script src="assets/js/owl.carousel.min.js"></script> -->
        <script src="assets/js/jquery.magnific-popup.js"></script>
        <script src="assets/js/jquery.easing.1.3.js"></script>
        <!-- <script src="assets/css/slick/slick.js"></script> -->
        <script src="assets/css/slick/slick.min.js"></script>
        <script src="assets/js/jquery.collapse.js"></script>
        <script src="assets/js/bootsnav.js"></script>

      <!--버블js  -->
      <script src="assets/js/bubble.js"></script>
        
        <script src="assets/js/plugins.js"></script>
        <script src="assets/js/main.js"></script>

    </body>
</html>