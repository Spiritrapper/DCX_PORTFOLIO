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



        <!--Theme custom css -->
        <link rel="stylesheet" href="assets/css/style_login.css">
        <!--<link rel="stylesheet" href="assets/css/colors/maron.css">-->

        <!--Theme Responsive css-->
        <link rel="stylesheet" href="assets/css/responsive.css" />


        <script src="assets/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
        
       <!--폰트어썸 -->
       <script src="https://kit.fontawesome.com/664170947c.js" crossorigin="anonymous"></script>
       <!--로그인관련  -->
       <link rel="stylesheet" href="./login.css">
       <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Barriecito&family=Sunflower:wght@300&display=swap" rel="stylesheet">
       <!--ajax및카카오로그인  -->
       <script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
      <script src="assets/js/kakaoLogin.js"></script>
      <!-- 애니메이트라이브러리 -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
       
    </head>

    <body data-spy="scroll" data-target=".navbar-collapse">


        <!--header include 시작  -->
    <jsp:include page="header.jsp"></jsp:include>
    <!--header include 끝  -->

            <!--Home Sections-->
         <br><br>
            <section id="" class="">
               <div class="overlay"></div> 
                <div class="container"> 
                    <div class="row">
                     <div class="main_home text-center">
                            <div class="col-md-12">
                                <div class="hello_slid">
                                   <div class="slid_item">
                              
                                        <!-- 로그인 부분 -->
                                      
                                         <div class="wrap">
                                      
                                         
                                         
                               
                                  
                                            
                <div id="login_right2" class="login_right">
                    
                    
 <!--   로그인 form 시작             -->
             <div>
                
                 <div class="bubble_Zzz"></div>
                 <div class="bubble_Zzz" style="animation-delay: 1s;"></div>
                    <img class="Zzz animate__animated animate__backInLeft animate__fast"alt="" src="assets/images/Zzz.png">
                    
                    <img class="ZzzM animate__animated animate__backInLeft animate__fast"alt="" src="assets/images/ZzzM.png">
                    
                </div>    
                    <form id="loginForm"  action="member/login" method="post" >
                        
                  <h2>Login </h2>
                        <div class="inputbox">
                           <ion-icon name="person-circle-outline"></ion-icon>
                            
                            
 <!-- 아이디 입력란 -->
                            <input type="text" style="color: black" required name="id" id="" placeholder="Please enter your id">
                            <label for="">ID</label>
                        
                        </div>

                        <div class=inputbox>
                            <ion-icon name="lock-closed-outline"></ion-icon>
                            
  <!-- 패스워드 입력란 -->
                            <input type="password"  style="color: black" required name="pw" id="" placeholder="Please enter your password">
                           <label for="pw">password</label>
                        </div>

                        <div class="login_etc">
                            
                          <div class="login_sns">
                            <!-- <li><a href=""><i class="fab fa-instagram"></i></a></li> -->
                            
                            <li><a href=""><img src="assets/images/naver_icon.png"></a></li>
                            <li><a href=""><img src="assets/images/google_icon.png"></a></li>
                            <li><a onclick="kakaoLogin();" href="javascript:void(0)"><img src="assets/images/kakao_icon.png"></a></li>
                            <!-- <li><a href=""><i class="fab fa-twitter"></i></a></li> -->
                          </div>
                  </div>
                        
                        
<!-- 로그인 서브밋 -->
                   
                          <button type="submit" class="login_1" value="Login" >Login</button>
                            
                            <!-- <a href=""><input class="join_1" type="button" value="Join"></a> -->
                            <!-- <div class="join_1">Join</div> -->
                            <br>
                          <div class="register">
                               <div class="join_1">Don't have account register</div>
                              
                        
                          </div>
                  
                   
                      </form> <!-- login 끝 -->
                       
                       
            </div>
            
<!-- 회원가입폼 시작 -->
             <div id="joinForm" class="login_right hidden">
                    
                    
 <!--   로그인 form 시작             -->
                    
                    <form id="loginForm"  action="member/join" method="post" >
                        
                  <h2>회원가입</h2>
                        
                        
                            
                            
 <!-- 아이디 입력란 -->
                            
                          <div class="form-group">
                             <ion-icon name="person-circle-outline"></ion-icon>
                             <input type="text"   style="color: black" id="" placeholder="아이디" name="id" required>
                       
                             <label for="id">ID</label>
                           </div>
                  
  <!-- 패스워드 입력란 -->                  
                   
                        
                        
                        <div class="form-group">
                            <ion-icon name="lock-closed-outline"></ion-icon>
                            

                            <input type="password"  style="color: black" name="pw" id="" placeholder="Please enter your password">
                           <label for="password">password</label>
                        </div>
   <!-- 이메일 입력란 -->                       
                         <div class="form-group">
                             <ion-icon name="mail-outline"></ion-icon>
                       <input type="text"  style="color: black" id="" placeholder="이메일" name="email" required>
                       <label for="email">이메일</label>
                         </div>
 <!-- 생년 월일 -->                        
                         <div class="form-group">
                            <ion-icon class="icon_happy" name="happy-outline"></ion-icon>   
                       <label for="birthdate">생년월일</label>
                       <input type="date"  style="color: black" class="input" name="birthdate">
                         </div>
<!-- 그룹 확인 -->                         
                         
                       <label for="job"></label>
                   
                       <select id="" name="job" required>
                             <option value="">- 그룹을선택하세요 -</option>   
                           <option value="선생님">선생님</option>
                           <option value="강사 ">강사</option>   
                           <option value="기타">기타</option>
                       </select>
                          
                  
                        
                        
                        
<!-- 로그인 서브밋 -->
                     
                         
                            
                            <!-- <a href=""><input class="join_1" type="button" value="Join"></a> -->
                            <!-- <div class="join_1">Join</div> -->
                            
                           <div class="register">
                               <br><br>
                               <div class="join_1">로그인창으로 돌아가기</div>
                              
                        
                          </div>
                          <br>
                     <input class="join_submit" type="submit" value="회원가입">
                   
                      </form> 
                       
            </div>
            
<!-- 회원가입폼 종료 -->
                
<!-- 회원가입 폼 -->
<!--                 
                <form id="joinForm" class="login_right hidden" action="member/join" method="post" >
                   <h2>Join</h2>
                   
                   <div class="form-group">
                       <label for="id">아이디</label>
                       <input type="text" id="" placeholder="아이디" name="id" required>
                   </div>
                   
                   <div class="form-group">
                       <label for="password">비밀번호</label>
                       <input type="password" id="" placeholder="패스워드" name="pw" required>
                   </div>                                    
                   <div class="form-group">
                       <label for="email">이메일</label>
                       <input type="text" id="" placeholder="이메일" name="email" required>
                   </div>
                  
                   <div class="form-group">
                       <label for="birthdate">생년월일</label>
                       <input type="date" class="input" name="birthdate">
                   </div>
                   <div class="form-group">
                       <label for="job">그룹</label>
                       <br>
                       <select id="" name="job" required>
                           <option value="선생님">선생님</option>
                           <option value="센세">센세</option>
                           <option value="기타">기타</option>
                       </select>
                   </div>
                   
                   <input class="join_submit" type="submit" value="회원가입">
               </form>
                -->
               
            </div>
                                       
                                        
                                        
                                    </div><!-- End off slid item -->
                                </div>
                            </div>

                        </div>


                    </div><!--End off row-->
                </div><!--End off container -->
            </section> <!--End off Home Sections-->



            <!--Featured Section-->
            <!-- footer 인클루드 부분 시작 -->
         <jsp:include page="footer.jsp"></jsp:include>
         <!-- footer 인클루드 부분 종료 -->
   



        </div>
        
            
        <!-- 로그인페이지아이콘 -->
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
      <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
        
            
      
        <!-- JS includes -->
      <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script> -->
         <script src="assets/js/vendor/jquery-1.11.2.min.js"></script>
         <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.ripples/0.5.3/jquery.ripples.min.js"></script>
   
       
        
        <script src="assets/js/vendor/bootstrap.min.js"></script>
        
        <!--로그인 물결-->
        
      
        <script src="assets/js/owl.carousel.min.js"></script>
        <script src="assets/js/jquery.magnific-popup.js"></script>
        <script src="assets/js/jquery.easing.1.3.js"></script>
        <script src="assets/css/slick/slick.js"></script>
        <script src="assets/css/slick/slick.min.js"></script>
        <script src="assets/js/jquery.collapse.js"></script>
        <script src="assets/js/bootsnav.js"></script>

      <!-- 카카오 로그인 -->
         <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
   
         <script src="assets/js/kakaoLogin.js"></script>

        <script src="assets/js/plugins.js"></script>
        <script src="assets/js/main.js"></script>

    </body>
</html>