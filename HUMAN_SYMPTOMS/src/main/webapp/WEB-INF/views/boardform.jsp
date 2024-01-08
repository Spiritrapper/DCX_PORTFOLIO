<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<!--
	Editorial by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
<title>건강 나침반</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<script src="https://kit.fontawesome.com/8fba072206.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="assets/css/main.css" />
</head>
<body class="is-preload">

	<!-- Wrapper -->
	<div id="wrapper">
		<nav class="navbar">
			<div class="navbar_logo">
				<a href="/bigdata" style="color: white;"><img src="assets/images/betterhealth.png" width=30px" height="30px"> 건강 나침반</a>
			</div>

			<ul class="navbar_menu">
				<c:choose>	
					<c:when test="${empty loginMember}">
						<li><a id="board" href="/bigdata/board" style="color: white; padding: 0px;">게시판</a></li>
						<li><a href="/bigdata/" style="color: white; padding: 0px;">질병/질환</a></li>
						<li><a href="/bigdata/map" style="color: white; padding: 0px;">병원 찾기</a></li>
						<li><a href="/bigdata/login" style="color: white; padding: 0px;">로그인</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="/bigdata/board" style="color: white; padding: 0px;">게시판</a></li>
						<li><a href="/bigdata/" style="color: white; padding: 0px;">질병/질환</a></li>
						<li><a href="/bigdata/map" style="color: white; padding: 0px;">병원 찾기</a></li>
						<li><a href="/bigdata/member/logout" style="color: white; padding: 0px;">로그아웃</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
			
			<ul class="navbar_icons">
				
			</ul>

		</nav>
		<!-- Main -->
		<div id="main">
			<div class="inner">

				<!-- Header -->
				<header id="header">
				</header>

				<!-- Content -->
				<section style="padding-left: 30px; padding-right: 30px">
					<header class="main">
						<h1 style="text-align: center">
					        <span>건</span>
					        <span>강</span>
					        <span>한</span>
					        <span></span>
					        <span></span>
					        <span>사</span>
					        <span>람</span>
					        <span>들</span>
					        <span>의</span>
					        <span></span>
					        <span></span>
					        <span>모</span>
					        <span>임</span>
					   <h1>
					</header>

					<div class="row gtr-200">
						<div class="col-6 col-12-medium" style="width: 100%">
							<!-- enctype 기본값 - application/x-www-form-urlencoded -->
							<form action="board/write" method="post">
								<!-- 파일이 있을 때만 enctype="multipart/form-data" 추가 -->
								<!-- BoardController의 "/board/write"와 매핑 -->
								<!-- 태그의 name 동일해야함 -->
								<div class="row gtr-uniform">
									<div class="col-12">
										<input type="text" id="title" name="board_title" placeholder="제목을 입력하세요" required autocomplete="off">
									</div>
									<div class="col-12">
										<textarea id="content" placeholder="내용을 입력하세요" name="board_content" rows="6" required></textarea>
									</div>
									<div class="col-12" style="display: none">
										<input type="text" id="writer" name="id" value="${loginMember.id}" required readonly>
									</div>
									<div class="col-12">
										<select name="dis_part">
											<option value="머리">머리</option>
											<option value="목">목</option>
											<option value="가슴">가슴</option>
											<option value="복부">복부</option>
											<option value="팔">팔</option>
											<option value="비뇨생식기">비뇨생식기</option>
											<option value="무릎/다리">무릎/다리</option>
											<option value="발">발</option>
										</select>
									</div>
									<!-- Break -->
									<div class="col-12">
										<ul class="actions">
											<li><input type="submit" value="작성 완료" class="primary" /></li>
											<li><input type="reset" value="초기화" /></li>
										</ul>
									</div>
								</div>
							</form>
						</div>

					</div>

				</section>

			</div>
		</div>

	</div>

	<!-- Scripts -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/browser.min.js"></script>
	<script src="assets/js/breakpoints.min.js"></script>
	<script src="assets/js/util.js"></script>
	<script src="assets/js/main.js"></script>
	<script src="assets/js/board.js"></script>
	<!-- <script>
		// id가 preImage인 img 태그 요소를 가져오기
		let preImage = document.getElementById("preImage"); // <img>
		let photo = document.getElementById("photo"); // <input>
		
		// photo(input)에 이벤트(파일 선택, 변경)가 발생했을 때 img의 src 속성값을 변경
		photo.addEventListener("change", e => {
			setImage(e.target);
		});
		
		function setImage(input){ // input : 첨부된 파일을 포함한 input 태그 요소
			
			// input 태그에 추가된 파일이 있는지
			if(input.files && input.files[0]){
				
				console.log(input.files);
				
				// FileReader 생성
				const reader = new FileReader();
				
				console.log(reader);
				
				reader.readAsDataURL(input.files[0]); // onload 발생
				
				reader.onload = e => { // FileReader가 생성되었는지 확인
					console.log(e);
					preImage.src = e.target.result;
				}
			}
		}
	</script> -->
</body>
</html>