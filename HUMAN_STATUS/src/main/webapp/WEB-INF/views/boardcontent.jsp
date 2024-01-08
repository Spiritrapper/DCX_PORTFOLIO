<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<!--[if gt IE 8]><!--> 
<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8">
        <title>Q&A</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
       
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/slick/slick.css"> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/slick/slick-theme.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/animate.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/iconfont.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/magnific-popup.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootsnav.css">
        
        <!-- 애니메이트라이브러리 -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
       
        <!--Theme custom css -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/board_content.css">
        <!--<link rel="stylesheet" href="assets/css/colors/maron.css">-->
        
        <!--Theme Responsive css-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/responsive.css" />
        
        <!-- main 로그인폰트  -->
        <link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet">
        <!-- respond js -->
        <script src="${pageContext.request.contextPath}/assets/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
        <!--폰트어썸 -->
        <script src="https://kit.fontawesome.com/664170947c.js" crossorigin="anonymous"></script>
    </head>

    <body data-spy="scroll" data-target=".navbar-collapse">
        <!--header include 시작  -->
        <jsp:include page="header.jsp"></jsp:include>
        <!--header include 끝  -->

        <!-- Home Sections-->
        <section id="home" class="home bg-black fix">
            <div class="overlay"></div>
            <div class="container">
                <div class="row">
                    <div class="main_home text-center">
                        <div class="col-md-12 ">
                            <section class="board_content" style="max-height: 600px; overflow-y: auto;">
                                <c:if test="${not empty board}">
                                    <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">	
                                        <thead>
                                            <tr><!-- 테이블의 행, 한줄 -->
                                                <th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글보기</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td style="width: 20%;">글 제목</td>
                                                <td colspan="2" style="text-align: left;">
                                                    ${board.board_title}
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>내용</td>
                                                <td colspan="2" style="height: 300px;text-align: left;">
                                                    ${board.board_content}
                                                </td>
                                            </tr>
                                           
        									<tr>
            								<td colspan="3" style="text-align: right;">
                								<!-- Your "Return to Q&A" button goes here -->
                							<a class="QAbtn"href="/bigdata/board">돌아가기</a>
                
            								</td>
        									</tr>
                                        </tbody>
                                    </table>
                                    
                                    <!-- 댓글 입력 폼 -->
                                    <div id="comment-form">
                                       
                                        <form action="${pageContext.request.contextPath}/board/${board.board_idx}/addComment" method="post">
                                            <!-- 댓글 내용 입력 필드의 name을 "cmt_content"로 변경 -->
                                            <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                                            <!-- <textarea name="cmt_content" required></textarea> -->
                                            <td style="border-bottom:none;" valign="middle"><br><br></td>
                                            <td><input type="text" style="height:100px;" class="form-control" placeholder="상대방을 존중하는 댓글을 남깁시다." name = "cmt_content" required></td>
                                            <td><br><br><input type="submit" class="btn-primary pull" value="댓글 작성"></td>
                                            <!-- 게시글의 ID를 전달하기 위해 input 요소 추가 -->
                                            <input type="hidden" name="board_idx" value="${board.board_idx}">
                                           <!--  <button type="submit" >댓글 작성</button> -->
                                           </table>
                                        </form>
                                    </div>
    
                                    <!-- 댓글이 있는 경우 표시 -->
                                    <c:if test="${not empty commentList}">
                                        
                                        <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
									<tbody>
																
											 <c:forEach var="comment" items="${commentList}">	
											 <tr>
                    						<td align="left">${loginMember.id} <br>
                   							 ${comment.cmt_content}</td>
               							 	</tr>
											</c:forEach>
										
									</tbody>
									</table>
                                        </c:if>
                                </c:if>
                                        
                                        
                                        
                                        <%-- <h5> 
                                            <div style="text-align: left; class="card-header bg-light">
                                                <i class="fa fa-comment fa"></i> REPLY
                                            </div>
                                        </h5>
                                        <ul>
                                            <c:forEach var="comment" items="${commentList}">
                                                <li style="text-align: left; margin-right: 10px;">${comment.cmt_content}</li>
                                            </c:forEach>
                                        </ul>
                                    </c:if>
                                </c:if> --%>
                            </section>                       
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- footer 인클루드 부분 시작 -->
        <jsp:include page="footer.jsp"></jsp:include>
        <!-- footer 인클루드 부분 종료 -->
        <!-- 페이지 연결을 위한 코드 끝 -->     
    </body>

    <!-- JS includes -->
    <script src="${pageContext.request.contextPath}/assets/js/vendor/jquery-1.11.2.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/vendor/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery.magnific-popup.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery.easing.1.3.js"></script>
    <script src="${pageContext.request.contextPath}/assets/css/slick/slick.js"></script>
    <script src="${pageContext.request.contextPath}/assets/css/slick/slick.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery.collapse.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootsnav.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/plugins.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</