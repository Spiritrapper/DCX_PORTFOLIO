<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>건강 나침반</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	
	<!-- css파일경로 입력 부분 -->
<link rel="stylesheet" href="assets/css/index.css" />


</head>
<body>
<img src="assets/images/bird.png" alt="" class="bird_img">
        <img src="assets/images/bird.png" alt="" class="bird_img2">
<div class="container right-panel-active" style="background-image: url('https://png.pngtree.com/thumb_back/fw800/background/20230525/pngtree-women-holding-a-red-heart-in-their-hands-image_2620007.jpg');">
  <div class="container__form container--signup">
    <form action="member/join" class="form" method="post">
    <!-- MemberController의 "/member/join"과 매핑 -->
      <h2 class="form__title">회원가입</h2>
      <input type="text" name="id" placeholder="아이디" class="input" autocomplete="off">
      <input type="password" name="pw" placeholder="패스워드" class="input">
      <!-- <input type="password" placeholder="패스워드 확인" class="input"> -->

	  <div class="input" style="text-align: left;">
	  <label for="male_radio" >남</label>
      <input type="radio" name="gender" id="male_radio" value="M">
      <label for="female_radio" >여</label>                            
      <input type="radio" name="gender" id="female_radio" value="F"> 
       </div>
      <input type="date" class="input" name="birthdate">
	  <input type="submit" class="btn" value="회원가입">
    </form>
  </div>

  <div class="container__form container--signin">
    <form action="member/login" class="form" method="post">
    <!-- MemberController의 "/member/login"과 매핑 -->
      <h2 class="form__title">로그인</h2>
      <input type="text" name="id" placeholder="아이디" class="input" autocomplete="off">
      <input type="password" name="pw" placeholder="패스워드" class="input" >
      <input type="submit" class="btn" value="로그인">
      <a href="/bigdata" class="btn">돌아가기</a>
    </form>
  </div>

  <!-- Overlay -->
  <div class="container__overlay">
    <div class="overlay">
      <div class="overlay__panel overlay--left">
        <button class="btn" id="signIn">로그인</button>
      </div>
      <div class="overlay__panel overlay--right">
        <button class="btn" id="signUp">회원가입</button>
      </div>
    </div>
  </div>
</div>
	<!-- js파일경로 입력 부분 -->
	<script src="assets/js/index.js"></script>
	<script src="assets/js/heart-balloon.js"></script>
</body>
</html>