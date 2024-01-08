<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	if (session.getAttribute("loginMember") == null) {
	    response.sendRedirect("login");
	}
%>
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
<link rel="stylesheet" href="assets/css/level.css" />
</head>
<script>
	function selChange() {
		/* var sel = document.getElementById('cntPerPage').value; */
		location.href="board?nowPage=${paging.nowPage}&cntPerPage=10";
	}
</script>
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
						<a href="board" style="text-align: center"><h1 style="text-align: center;">
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
					        
					      </h1></a> <!-- 게시판 텍스트 클릭시 게시판 페이지로 이동 -->
					</header>
					<div class="row gtr-200">
						<div class="col-6 col-12-medium" style="width: 100%">
							<div class="table-wrapper">
							
							
								<table style="background-color: white; opacity: 0.8; text-align: center;">
									<thead>
										<form action="search" method="get"> <!-- BoardController의 "/search"와 매핑 -->
											<input type="text" placeholder="포함할 단어를 입력" id="search" name="search" autocomplete="off" style="width: 160px; display: inline; margin-left: 10px; margin-right: 10px;" value="${search }">
																							<!-- search() 메소드에 파라미터와 name이 일치 -->
											<select name="dis_part" style="width: 160px; display: inline; margin-left: 10px; margin-right: 10px;"> <!-- search() 메소드에 파라미터와 name이 일치 -->
												<option value="">전체</option> <!-- 부위를 선택하지 않았을 때, 모든 부위에 대해 나와야 함-->
												<option value="머리">머리</option>
												<option value="목">목</option>
												<option value="가슴">가슴</option>
												<option value="복부">복부</option>
												<option value="팔">팔</option>
												<option value="비뇨생식기">비뇨생식기</option>
												<option value="무릎/다리">무릎/다리</option>
												<option value="발">발</option>
											</select>
											<select name="sort" style="width: 160px; display: inline; margin-left: 10px; margin-right: 10px;"> <!-- search() 메소드에 파라미터와 name이 일치 -->
												<option value="board_idx">없음</option> <!-- 정렬 기준이 없을 때는 그냥 가장 최근에 작성된 게시글부터 보이게 함 -->
												<option value="board_comments">댓글수</option>
												<option value="board_views">조회수</option>
												<option value="board_recommends">추천수</option>
											</select>
											<input type="text" style="display: none" name="nowPage" value="1">
											<input type="submit" value="검색" style="margin-left: 10px; margin-right: 10px;">
										</form>
										<br>
										<br>
										<tr>
											<th></th>
											<th>제목[댓글수]</th>
											<th>작성자</th>
											<th>작성일</th>
											<th>부위</th>
											<th>조회수</th>
											<th>추천수</th>
											<th>삭제</th>
										</tr>
									</thead>
									<tbody>
										<!-- 출력1 -->
										<!-- 게시글 정보들을 나타냄 -->
										<c:forEach items="${list }" var="b"> <!-- 게시판 페이지에 t_board 테이블에 저장된 모든 게시글 정보를 나타냄 -->
											<tr>
												<td>${b.board_idx }</td>
												<td><a href="board/content/${b.board_idx }" style="color:black">${b.board_title }</a> <c:if test="${b.board_comments > 0}"> [${b.board_comments }]</c:if></td>
												<!-- 글 제목 옆에 댓글수 표시(댓글이 없으면 아무 것도 안보임, 1개 이상일 경우 댓글수 보임) -->
												<td>
													<c:if test="${b.id_level == 1 }">
			                                          <div class="lv_low lv_1">${b.id_level}</div>
			                                       </c:if>
			                                       <c:if test="${b.id_level == 2 }">
			                                          <div class="lv_low lv_2">${b.id_level}</div>
			                                       </c:if>
			                                       <c:if test="${b.id_level == 3 }">
			                                          <div class="lv_low lv_3">${b.id_level}</div>
			                                       </c:if>
			                                       <c:if test="${b.id_level == 4 }">
			                                          <div class="lv_low lv_4">${b.id_level}</div>
			                                       </c:if>
			                                       <c:if test="${b.id_level == 5 }">
			                                          <div class="lv_high lv_5">${b.id_level}</div>
			                                       </c:if>
			                                       <c:if test="${b.id_level == 6 }">
			                                          <div class="lv_high lv_6">${b.id_level}</div>
			                                       </c:if>
			                                       <c:if test="${b.id_level == 7 }">
			                                          <div class="lv_high lv_7">${b.id_level}</div>
			                                       </c:if>
			                                       <c:if test="${b.id_level == 8 }">
			                                          <div class="lv_high lv_8">${b.id_level}</div>
			                                       </c:if>
			                                       <c:if test="${b.id_level >= 9 }">
			                                          <div class="lv_high lv_9">${b.id_level}</div>
			                                       </c:if>
												${b.id }</td>
												<td>${b.created_at }</td>
												<td>${b.dis_part }</td>
												<td>${b.board_views }</td>
												<td>${b.board_recommends }</td>
												<c:if test="${memberId eq b.id}"> <!-- 세션에 로그인한 사용자와 해당 게시글 작성자가 동일할 경우, 삭제할 수 있음 -->
													<td><a href="board/content/${b.board_idx}/delete" style="color:black">삭제</a></td>					
												</c:if>
												<c:if test="${memberId ne b.id}">
													<td></td>									
												</c:if>
											</tr>
										</c:forEach>
										<!-- 페이지번호를 출력함 -->
										<!-- 출력2 -->
									</tbody>
								</table>
								<div style="display: block; text-align: center;">		
												<c:if test="${paging.startPage != 1 }">
													<a href="/bigdata/search?search=${search}&dis_part=${dis_part}&sort=${sort}&nowPage=${paging.startPage - 1}$cntPerPage=${paging.cntPerPage}&cntPerPage=${paging.cntPerPage}">&lt;</a>
												</c:if>
												<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
													<c:choose>
														<c:when test="${p == paging.nowPage }">
															<b>${p }</b>
														</c:when>
														<c:when test="${p != paging.nowPage }">
															<a href="/bigdata/search?search=${search}&dis_part=${dis_part}&sort=${sort}&nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
														</c:when>
													</c:choose>
												</c:forEach>
												<c:if test="${paging.endPage != paging.lastPage}">
													<a href="/bigdata/search?search=${search}&dis_part=${dis_part}&sort=${sort}&nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a>
												</c:if>
											</div>
												<button onclick="location.href='boardform'" class="btn btn-sm btn-success">글작성</button>
												<!-- 글 작성 버튼 클릭 시 글 작성 페이지로 이동 -->
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
	</div>
	<div class="map_wrap hidden">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div>
                <form onsubmit="searchPlaces(); return false;">
                    키워드 : <input type="text" value="${search }" id="keyword" size="15"> 
                    <button type="submit">검색하기</button> 
                </form>
            </div>
        </div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
</div>
	<!-- Scripts -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/browser.min.js"></script>
	<script src="assets/js/breakpoints.min.js"></script>
	<script src="assets/js/util.js"></script>
	<script src="assets/js/main.js"></script>
	<script src="assets/js/board.js"></script>
</html>