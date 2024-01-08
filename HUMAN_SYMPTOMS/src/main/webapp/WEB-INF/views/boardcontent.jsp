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
<link rel="stylesheet" href="/bigdata/assets/css/main.css" />
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
						<li><a href="/bigdata" style="color: white; padding: 0px;">질병/질환</a></li>
						<li><a href="/bigdata/map" style="color: white; padding: 0px;">병원 찾기</a></li>
						<li><a href="/bigdata/login" style="color: white; padding: 0px;">로그인</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="/bigdata/board" style="color: white; padding: 0px;">게시판</a></li>
						<li><a href="/bigdata" style="color: white; padding: 0px;">질병/질환</a></li>
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
					        
					      </h1>
					</header>

					<div class="row gtr-200">
						<div class="col-6 col-12-medium" style="width: 100%">
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<span><h2>${board.board_title }</h2></span>
						<span><h4>${board.id }<div style="width: 20px; display: inline-block; text-align: center;">|</div>${board.created_at }</h4></span>
							<table style="background-color: white; opacity: 0.8;">
								<tr>
									<td height="400px"><h4>${board.board_content }</h4></td>
								</tr>
								<tr>
									<c:if test="${check eq 0}">
										<td align="center"><a href="${board.board_idx }/recommend"><button>👍${count}</button></a></td>
									</c:if>
									<c:if test="${check ne 0}">
										<td align="center"><a href="${board.board_idx }/recommendCancel"><button>👎${count}</button></a></td>
									</c:if>
								</tr>
								<tr>
									<td align="center">
										<a href="/bigdata/board" class="btn"><button>리스트</button></a>
										<c:if test="${memberId eq board.id }">
											<a href="${board.board_idx }/delete"><button>삭제</button></a>
										</c:if>
									</td>
								</tr>
							</table>
							<form action="${board_idx}/addComment" method="post" enctype="multipart/form-data">
								<p><textarea cols="30" rows="10" placeholder="댓글을 입력하세요" name="cmt_content"></textarea></p>
								<p><input type="submit" value="작성"></p>
							</form>
							<div class="row gtr-200">
								<div class="col-6 col-12-medium" style="width: 100%">
								
								</div>
							</div>
							<table style="background-color: white; opacity: 0.8;">
								<thead>
									<tr>
										<td colspan="4"><h3>전체 댓글</h3></td>
									</tr>
								</thead>
								<c:forEach items="${commentList }" var="c">
									<tbody>
										<tr>
											<td width="200px">${c.id }</td>
											<td width="800px">${c.cmt_content }</td>
											<td width="200px">${c.created_at }</td>
											<c:if test="${memberId eq c.id}">
												<td><a href="${board_idx}/${c.cmt_idx}/deleteComment">X</a></td>									
											</c:if>
											<c:if test="${memberId ne c.id}">
												<td></td>									
											</c:if>
										</tr>
									</tbody>
								</c:forEach>
							</table>
						</div>

					</div>

				</section>

			</div>
		</div>

	</div>

	<!-- Scripts -->
	<script src="/bigdata/assets/js/jquery.min.js"></script>
	<script src="/bigdata/assets/js/browser.min.js"></script>
	<script src="/bigdata/assets/js/breakpoints.min.js"></script>
	<script src="/bigdata/assets/js/util.js"></script>
	<script src="/bigdata/assets/js/main.js"></script>
	<script src="/bigdata/assets/js/board.js"></script>
	<script>
		const board = document.querySelector('#board');
		
		board.addEventListener('click',()=>{
			alert('게시판은 로그인 후에 이용할 수 있습니다');
		});
	</script>
</body>
</html>