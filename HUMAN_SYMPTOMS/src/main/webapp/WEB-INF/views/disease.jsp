<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.smhrd.bigdata.entity.Disease" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>건강 나침반</title>
<meta charset="utf-8" />
<meta name="viewport"
   content="width=device-width, initial-scale=1, user-scalable=no" />

<!-- css 부분 경로-->
<!-- bootstrap css -->
<link rel="stylesheet" type="text/css"
   href="/bigdata/assets/css/bootstrap.min.css">
<!-- style css -->
<link rel="stylesheet" type="text/css"
   href="/bigdata/assets/css/disease.css">
<link rel="stylesheet" href="/bigdata/assets/css/main.css" />

</head>
<body>

<% 
List<Disease> list = (List) session.getAttribute("list");
int n = list.size(); 
%>
   
   
   <div class="header_section">
      <!-- 네브바 시작 -->
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

      <!-- 질병 정보 출력부분 -->
      <div class="banner_section layout_padding" >
         <div class="container-fluid">
            <div id="banner_slider" class="carousel slide" data-ride="carousel">
               <div class="carousel-inner">

                  <!-- 질병 반복문 -->

                  <!-- 일단은 n에 임의의 값  입력 (list의 길이로 하면 될듯) -->
                  
                  
                  <%
                  for (int i = 1; i <= n; i++) {
                  %>
                  <%
                  if (i == 1) {
                  %>
                  <div class="carousel-item active" id="dis<%=i%>_div">
                     <%
                     } else {
                     %>
                     <div class="carousel-item" id="dis<%=i%>_div">
                        <%
                        }
                        %>

                        <div class="row">
                           <div class="col-md-6">
                              <div class="banner_taital_main" >
                                 
                                 <!-- 질병명 -->
                                 <h1 class="banner_taital">
                                    
                                    <% switch (i) {
                                     case 1: %>
                                        
                                         <%=list.get(0).getDis_name()%>                                       
                                         <% break;
                                         
                                     case 2: %>
                                         <%=list.get(1).getDis_name()%>
                                         <% break;
                                         
                                     case 3: %>
                                         <%=list.get(2).getDis_name()%>
                                         <% break;
                                    
                                     default:
                                         
                                         break;
                                 } %>
                                    
                                    </h1>

                  <!-- 작은글씨 여기부터 세부 내용 -->
                                 <div class="banner_text">
                                    <!-- 세부 1 이름 -->
                                    <div class="detail_subject"> 
                                    <% switch (i) {
                                     case 1: %>
                                        
                                         <%=list.get(0).getDis_detail1()%>                                       
                                         <% break;
                                         
                                     case 2: %>
                                         <%=list.get(1).getDis_detail1()%>
                                         <% break;
                                         
                                     case 3: %>
                                         <%=list.get(2).getDis_detail1()%>
                                         <% break;
                                    
                                     default:
                                         
                                         break;
                                 } %>
                                    </div>
                                    <!-- 세부 1 내용 -->
                                    
                                    <% switch (i) {
                                     case 1: %>
                                        
                                         <%=list.get(0).getDis_detail_content1()%>                                       
                                         <% break;
                                         
                                     case 2: %>
                                         <%=list.get(1).getDis_detail_content1()%>
                                         <% break;
                                         
                                     case 3: %>
                                         <%=list.get(2).getDis_detail_content1()%>
                                         <% break;
                                    
                                     default:
                                         
                                         break;
                                 } %> 
                                 </div>
                                 
                                 <div class="banner_text">
                                 
                                    <div class="detail_subject"> <!-- 세부 2 이름 -->
                                    <% switch (i) {
                                     case 1: %>
                                         <%=list.get(0).getDis_detail2()%>                                       
                                         <% break;
                                         
                                     case 2: %>
                                         <%=list.get(1).getDis_detail2()%>
                                         <% break;
                                         
                                     case 3: %>
                                         <%=list.get(2).getDis_detail2()%>
                                         <% break;
                                    
                                     default:
                                         
                                         break;
                                 } %>
                                    </div>
                                    <!-- 세부 2 내용 -->
                                    <% switch (i) {
                                     case 1: %>
                                         <%=list.get(0).getDis_detail_content2()%>                                       
                                         <% break;
                                         
                                     case 2: %>
                                         <%=list.get(1).getDis_detail_content2()%>
                                         <% break;
                                         
                                     case 3: %>
                                         <%=list.get(2).getDis_detail_content2()%>
                                         <% break;
                                    
                                     default:
                                         
                                         break;
                                 } %> 
                                 
                                 <div class="banner_text">
                                 
                                    <div class="detail_subject"> <!-- 세부 3 이름 -->
                                    <% switch (i) {
                                     case 1: %>
                                         <%=list.get(0).getDis_detail3()%>                                       
                                         <% break;
                                         
                                     case 2: %>
                                         <%=list.get(1).getDis_detail3()%>
                                         <% break;
                                         
                                     case 3: %>
                                         <%=list.get(2).getDis_detail3()%>
                                         <% break;
                                    
                                     default:
                                         
                                         break;
                                 } %>
                                    </div>
                                    <!-- 세부 3 내용 -->
                                    <% switch (i) {
                                     case 1: %>
                                         <%=list.get(0).getDis_detail_content3()%>                                       
                                         <% break;
                                         
                                     case 2: %>
                                         <%=list.get(1).getDis_detail_content3()%>
                                         <% break;
                                         
                                     case 3: %>
                                         <%=list.get(2).getDis_detail_content3()%>
                                         <% break;
                                    
                                     default:
                                         
                                         break;
                                 } %> 
                                 </div>
                                 </div>
                              </div>
                           </div>
                           <div class="col-md-6">
                              <!-- 운동 동영상 삽입 -->
                              <div class="detail_subject">추천 운동</div>
                              
                        
                        <!-- 운동영상 태그 속 동영상 링크 -->
                                 <iframe class="ex_video" src="
                                 
                                 <% switch (i) {
                                     case 1: %>
                                         <%= list.get(0).getDis_exercise_link() %>                                       
                                         <% break;
                                         
                                     case 2: %>
                                         <%= list.get(1).getDis_exercise_link() %>
                                         <% break;
                                         
                                     case 3: %>
                                         <%= list.get(2).getDis_exercise_link() %>
                                         <% break;
                                    
                                     default:
                                         
                                         break;
                                 } %> 
                                                                                                                                                                                             
                                 " title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
                                 
                                 
                                 <div>
                                 <div class="detail_subject">추천 식단</div>
                                 <img alt="" src="
                                 
                                 <% switch (i) {
                                     case 1: %>
                                         <%= list.get(0).getDis_diet_img() %>                                       
                                         <% break;
                                         
                                     case 2: %>
                                         <%= list.get(1).getDis_diet_img() %>
                                         <% break;
                                         
                                     case 3: %>
                                         <%= list.get(2).getDis_diet_img() %>
                                         <% break;
                                    
                                     default:
                                         
                                         break;
                                 } %>
                                 ">
                                 <div>
                                 <% switch (i) {
                                     case 1: %>
                                         <%= list.get(0).getDis_diet() %>                                       
                                         <% break;
                                         
                                     case 2: %>
                                         <%= list.get(1).getDis_diet()  %>
                                         <% break;
                                         
                                     case 3: %>
                                         <%= list.get(2).getDis_diet() %>
                                         <% break;
                                    
                                     default:
                                         
                                         break;
                                 } %>
                                 
                                 </div>                  
                                 </div>
                           </div>
                           
                        </div>
                     </div>
                     <%
                     }
                     %>

                  </div>
               </div>
            </div>
         </div>
         <!-- banner section end -->
      </div>
      <!-- header section end -->
      <!-- box section start -->
      <div class="container" >
         <div class="box_section">
            <div class="online_box">



               <!-- 질병버튼 반복문 -->
               <!-- n은 위에서 입력받았음 -->


               <%
               for (int i = 1; i <= n; i++) {
               %>
               <%
               if (i == 1) {
               %>
               <div class="online_box_left active" id="dis<%=i%>_btn">
                  <%
                  } else {
                  %>
                  <div class="online_box_left" id="dis<%=i%>_btn">
                     <%
                     }
                     %>

                     <div class="online_box_main">
                        <div class="box_left">
                           <div class="right_arrow">
                              <i class="fa fa-arrow-right"></i>
                           </div>
                        </div>
                        <div class="box_right">
                           <span class="appoinment_text">
                              
                              <% switch (i) {
                                     case 1: %>
                                         <%=list.get(0).getDis_name()%>                                       
                                         <% break;
                                         
                                     case 2: %>
                                         <%=list.get(1).getDis_name()%>
                                         <% break;
                                         
                                     case 3: %>
                                         <%=list.get(2).getDis_name()%>
                                         <% break;
                                    
                                     default:
                                         
                                         break;
                                 } %>
                              
                              <img class="dis_part_img" alt="" src="
                              <% switch (i) {
                                     case 1: %>
                                         <%= list.get(0).getDis_part_img() %>                                       
                                         <% break;
                                         
                                     case 2: %>
                                         <%= list.get(1).getDis_part_img() %>
                                         <% break;
                                         
                                     case 3: %>
                                         <%= list.get(2).getDis_part_img() %>
                                         <% break;
                                    
                                     default:
                                         
                                         break;
                                 } %>
                              "></span>                           
                        </div>
                     </div>
                  </div>
                  <%
                  }
                  %>
                  

               </div>
            </div>
         </div>
      </div>
   </div>

         <!-- 스크립트 부분 경로 -->

         <!-- 화면전환js -->
         <!-- <script src="js/jquery.min.js"></script> -->

         <script src="/bigdata/assets/js/board.js"></script>

         <script src="/bigdata/assets/js/bootstrap.bundle.min.js"></script>

         <script src="https://kit.fontawesome.com/8fba072206.js"
            crossorigin="anonymous"></script>

         <script>
         <%for (int i = 1; i <= n; i++) {%>
            const dis<%=i%>Div = document.getElementById('dis'+<%=i%>+'_div');
            const dis<%=i%>Btn = document.getElementById('dis'+<%=i%>+'_btn');
         <%}%>
      
         <%for (int i = 1; i <= n; i++) {%>
            dis<%=i%>Btn.addEventListener('click',function(){
            <%for (int j = 1; j <= n; j++) {%>
               <%if (i == j) {%>
                  dis<%=j%>Div.classList.add('active');
                  dis<%=j%>Btn.classList.add('active');
               <%} else {%>
                  dis<%=j%>Div.classList.remove('active');
                  dis<%=j%>Btn.classList.remove('active');
               <%}%>
            <%}%>
            });
         <%}%>
         </script>
         <script>
		const board = document.querySelector('#board');
		
		board.addEventListener('click',()=>{
			alert('게시판은 로그인 후에 이용할 수 있습니다');
		});
	</script>
	
</body>
</html>