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
        
         <!--폰트어썸 -->
        <script src="https://kit.fontawesome.com/664170947c.js" crossorigin="anonymous"></script>
    </head>

    <body data-spy="scroll" data-target=".navbar-collapse">
   
    

        <!-- Preloader -->
        <div id="loading">
            <div id="loading-center">
                <div id="loading-center-absolute">
                    <div class="object" id="object_one"></div>
                    <div class="object" id="object_two"></div>
                    <div class="object" id="object_three"></div>
                    <div class="object" id="object_four"></div>
                </div>
            </div>
        </div><!--End off Preloader -->
		
		<nav class="navbar navbar-default bootsnav navbar-fixed">
                
                <div class="navbar-top bg-grey fix">
                    <div class="container">
                        <div class="row">
                          
                        </div>
                    </div>
                </div>

    			<div class="container"> 
                    <div class="attr-nav">
                        <ul>
                            <li class="search"><a href="#"><i class="fa-solid fa-camera fa-bounce fa-lg"></i></a></li>
                        </ul>
                    </div> 

                    <!-- Start Header Navigation -->
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-menu">
                            <i class="fa fa-bars"></i>
                        </button>
                        <a class="navbar-brand" href="/bigdata/">
                            <!-- Logo 부분 이미지 -->
                            <img src="assets/images/jani_2.png" class="logo" alt="">
                            <!--<img src="assets/images/footer-logo.png" class="logo logo-scrolled" alt="">-->
                        </a>

                    </div>
                    <!-- End Header Navigation -->

  <!-- 네브바 menu -->
                    <div class="collapse navbar-collapse" id="navbar-menu">
                        <ul class="nav navbar-nav navbar-right">
                           
                <c:choose>	
					<c:when test="${empty loginMember}">
                            <li><a href="/bigdata/">Home</a></li>                    
                            <li><a class="cant1" href="/bigdata/history">History</a></li>
                            <li><a class="cant2" href="/bigdata/board">Q&A</a></li>
                            <li><a class="cant3" href="/bigdata/vcon">Video Chat</a></li>
                            <li><a href="/bigdata/login">Login</a></li>
                    </c:when>
					<c:otherwise>
                            <li><a href="/bigdata/">Home</a></li>                    
                            <li><a href="/bigdata/history">History</a></li>
                            <li><a href="/bigdata/board">Q&A</a></li>
                            <li><a href="/bigdata/vcon">Video Chat</a></li>
                            <li><a href="/bigdata/member/logout">Logout</a></li>					
					
					</c:otherwise>
				</c:choose>
                        </ul>
                    </div><!-- /.navbar-collapse -->
                    
                </div> 

            </nav>
            
        <script>
/* 왜 모든 클래스 불러오는게 안되는지 모르겠음 (querySelectorAll)도 안됨! */
        /*         
                const cant1 = document.getElementsByClassName('cant1');		
        		cant1.addEventListener('click',()=>{
        			alert('로그인 후에 이용할 수 있습니다');
        		});
        	 */       
        
        const cant1 = document.querySelector('.cant1');		
		cant1.addEventListener('click',()=>{
			alert('로그인 후에 이용할 수 있습니다');
		});
		
		const cant2 = document.querySelector('.cant2');		
		cant2.addEventListener('click',()=>{
			alert('로그인 후에 이용할 수 있습니다');
		});
		
		const cant3 = document.querySelector('.cant3');		
		cant3.addEventListener('click',()=>{
			alert('로그인 후에 이용할 수 있습니다');
		});		
		</script>
    </body>
    </html>