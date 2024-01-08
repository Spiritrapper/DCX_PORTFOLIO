<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.smhrd.bigdata.entity.History" %>  
   
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


        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/responsive.css" />
        <!--히스토리_etc  -->
        <link rel="stylesheet" href="assets/css/history_etc.css">

        <script src="assets/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
        <!--Chart.js 스크립트-->
         <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>

        <!-- fullcalendar CDN -->
        <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
        <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
        <!-- fullcalendar 언어 CDN -->
        <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
        
       <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
       <!-- jquery CDN -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
       
       <!--jsPDF저장  -->
       <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.2.61/jspdf.min.js"></script>
              		<script> 
    var userId = '${loginMember.id}';
    consol.log("아이디나오나?:",userId)
</script>
    <style>
    
    
        /* 차트들 스타일들 */
        .chart_No1 {
            /* max-width: 700px; */
            margin: 20px auto;
            display: block;
        }
        
        .chart_No2 {
            max-width: 400px;
            margin: 5px auto;
            display: block;
        }
    </style>
    
    
    </head>

    <body data-spy="scroll" data-target=".navbar-collapse">
    
<!-- db에서 불러오는 부분 -->
    <%
   List<History> list1 = (List) session.getAttribute("list1");
   int n = list1.size();
   %>
   
    <%
   List<History> list2 = (List) session.getAttribute("list2");
   int n2 = list2.size();
   %>

    <!--header include 시작  -->
    <jsp:include page="header.jsp"></jsp:include>



<!-- 그리드 시작 -->
      
         <section id="home" class="fix">

                                      
                <div class="history_wrap">
                   
                <div class="history_grid">
                <div>${loginMember.id}님 반갑습니다</div>
                <br>
                <div>날짜를 선택해 ${loginMember.id}님의 History를 확인해보세요!</div>
                <!-- 날짜명을 저장해줄 리스트 생성 -->                
                <% List<String> list_date = new ArrayList<>(); 
                list_date.add(list1.get(0).getTimestamp());               
                %>
                
<!-- 날짜명별 갯수를 저장해줄 리스트 생성 -->                
                <% List<Integer> list_date_count = new ArrayList<>();%>

<!-- 날짜를 특정 리스트에 저장 -->                
            <% for (int i = 1; i < n; i++) { %>
                <% if (!list1.get(i).getTimestamp().equals(list1.get(i - 1).getTimestamp())) { %>
                    <%list_date.add(list1.get(i).getTimestamp()); %>               
                <% } %>
            <% } %>
            
            <% int n1 = list_date.size(); %>
                
                
<!-- 날짜선택 select --> 
            <br>               
                <label for="dates">날짜 선택</label>
             <select id="dates" name="dates">
                <% for (int i = 0; i < n1; i++) { %>
                 <option value="<%=list_date.get(i) %>"><%=list_date.get(i) %></option>
                 
                 <% } %>
             </select>
             <button id="submitButton">조회</button>
             
             <% for (int j = 0; j < n1; j++) { %>
                <% list_date_count.add(0); %>
                <% for (int i = 0; i < n; i++) { %>                                             
                   <% if (list_date.get(j).equals(list1.get(i).getTimestamp())) { %>
                        
                        
                        <%int count = list_date_count.get(j);
                           list_date_count.set(j, count + 1); %>
                     <% } %>
                  <% } %>
                <% } %> 
                

<!-- 날짜별로 데이터의 갯수 출력 확인 -->                
<%--                 
                <%= list_date_count.get(0) %> 
                <%= list_date_count.get(1) %> 
                <%= list_date_count.get(2) %>     
              
 --%>                             
 
 <!-- 날짜들 데이터를 배열로 만들어서 저장해둠 -->
             <%
                String[] dataList = new String[list_date.size()]; // list_date 크기에 맞는 배열 생성
                for (int i = 0; i < list_date.size(); i++) {
                 dataList[i] = list_date.get(i); // list_date의 값들을 배열에 저장
                }
            %>
            
            
			<br>
            <button class="pdf_btn" onclick="generatePDF()">PDF 저장</button>
            <!-- 캘린더 -->
                <div id='calendar'></div>
                
                </div>
                
                <div class="history_grid"><span id='search_date' style="display: inline-block; font-size: 25px; margin-right: 250px;"><%=list_date.get(0)%></span>               
                시간에 따른 졸음 여부 및 총 졸음 인원수
                <span style="display: inline-block; margin-left: 320px;"></span>
                   <canvas id="mixedChart" class='chart_No1' width="900px" height="230px"></canvas>
                 <button id ="chartBtn0">전체</button>
                 <button id ="chartBtn1"><%=list2.get(0).getStt1()%></button>
                 <button id ="chartBtn2"><%=list2.get(0).getStt2()%></button>
                 <button id ="chartBtn3"><%=list2.get(0).getStt3()%></button>
                 <button id ="chartBtn4"><%=list2.get(0).getStt4()%></button>
                </div>
                <div class="history_grid"><span id="st_name">전체</span>학생의 졸음시간 비율 <br>
            <canvas id="Chart3" class="chart_No3" width="200px" height="200px"></canvas>
             
                </div>
                <div class="history_grid">
                	날짜별 개인의 수업시간 졸음비율
                   <canvas id="Chart2" class="chart_No2" width="400px" height="200px"></canvas>
                                <button id ="chartBtn2_1"><%=list2.get(0).getStt1()%></button>
                                <button id ="chartBtn2_2"><%=list2.get(0).getStt2()%></button>
                                <button id ="chartBtn2_3"><%=list2.get(0).getStt3()%></button>
                                <button id ="chartBtn2_4"><%=list2.get(0).getStt4()%></button>   
                   
                 <%-- <canvas id="mixedChart" class='chart_No1' width="700px" height="250px"></canvas>
                 <button id ="chartBtn0">전체</button>
                 <button id ="chartBtn1"><%=list2.get(0).getName()%></button>
                 <button id ="chartBtn2"><%=list2.get(1).getName()%></button>
                 <button id ="chartBtn3"><%=list2.get(2).getName()%></button>
                 <button id ="chartBtn4"><%=list2.get(3).getName()%></button> --%>
                 
                </div>
                
         </section>


            <!-- footer 인클루드 부분 시작 -->
            <jsp:include page="footer.jsp"></jsp:include>



        </div>
        

      <!-- history_Chart js코드 -->
      <script src="assets/js/history_chart.js"></script>
      <!-- history_etc js코드 -->
      <script src="assets/js/history_etc.js"></script>    

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
        
<!-- 꺾은선 그래프 스크립트 시작부분 -->        
        <script>
        
/*------------------------------ 첫번째 차트 만드는 부분 -------------------------------------------- */        
        let num = 0;
        let chartconfig;

        const btn0 = document.getElementById('chartBtn0');
        const btn1 = document.getElementById('chartBtn1');
        const btn2 = document.getElementById('chartBtn2');
        const btn3 = document.getElementById('chartBtn3');
        const btn4 = document.getElementById('chartBtn4');
        let st_name = document.getElementById('st_name');
        let tem = 0;
        
        /* list_date.get(0) : 2023-12-19 */
        /* list_date_count.get(0) : 22개 */
        
        const ctx = document.getElementById('mixedChart').getContext('2d');
        let mixedChart;
      
        btn0.addEventListener('click', function() {
            num = 0; // num 값을 1로 변경
            st_name.innerHTML = '전체';
            updateChart(); // updateChart 함수 호출
            updateChart3();
        });
        
        btn1.addEventListener('click', function() {
            num = 1; // num 값을 1로 변경
            st_name.innerHTML = '<%=list2.get(0).getStt1()%>';
            updateChart(); // updateChart 함수 호출
            updateChart3();
        });
        
        btn2.addEventListener('click', function() {
            num = 2; // num 값을 1로 변경
            st_name.innerHTML = '<%=list2.get(0).getStt2()%>';
            updateChart(); // updateChart 함수 호출
            updateChart3();
        });
        
        btn3.addEventListener('click', function() {
            num = 3; // num 값을 1로 변경
            st_name.innerHTML = '<%=list2.get(0).getStt3()%>';
            updateChart(); // updateChart 함수 호출
            updateChart3();
        });
        
        btn4.addEventListener('click', function() {
            num = 4; // num 값을 1로 변경
            st_name.innerHTML = '<%=list2.get(0).getStt4()%>';
            updateChart(); // updateChart 함수 호출
            updateChart3();
        });
        
/* 빈 배열을 정의하고, 배열에 list_date 값을 push해줌 */
   let dataList = [];
   
   <%
   for (int i = 0; i < n1; i++) { %>
      sessionStorage.setItem('dataList', '<%=list_date.get(i)%>');
      dataList.push(sessionStorage.getItem('dataList'));
   <% } %>

/* 선택된 날짜 출력부분 초기값 */
   let newText = dataList[0];

/* 빈 배열을 정의하고, 배열에 list_date_count 값을 push해줌 */
   
   let dataList_count = [];
   
   <%
   for (int i = 0; i < n1; i++) { %>
      sessionStorage.setItem('dataListCount', '<%=list_date_count.get(i)%>');
      dataList_count.push(sessionStorage.getItem('dataListCount'));
   <% } %>


/* 빈 배열을 정의하고, 배열에 list1의 st1 값을 push해줌 */   
   let dataList_st1 = [];   
   <%
   for (int i = 0; i < n; i++) { %>
      sessionStorage.setItem('dataListSt1', '<%=list1.get(i).getSt1()%>');
      dataList_st1.push(sessionStorage.getItem('dataListSt1'));
   <% } %>
   
   let dataList_st2 = [];   
   <%
   for (int i = 0; i < n; i++) { %>
      sessionStorage.setItem('dataListSt2', '<%=list1.get(i).getSt2()%>');
      dataList_st2.push(sessionStorage.getItem('dataListSt2'));
   <% } %>

   let dataList_st3 = [];   
   <%
   for (int i = 0; i < n; i++) { %>
      sessionStorage.setItem('dataListSt3', '<%=list1.get(i).getSt3()%>');
      dataList_st3.push(sessionStorage.getItem('dataListSt3'));
   <% } %>

   let dataList_st4 = [];   
   <%
   for (int i = 0; i < n; i++) { %>
      sessionStorage.setItem('dataListSt4', '<%=list1.get(i).getSt4()%>');
      dataList_st4.push(sessionStorage.getItem('dataListSt4'));
   <% } %>

   
/* 빈 배열을 정의하고, 배열에 list1의 st1 값을 push해줌 */   

   let dataList_timestamp = [];
   
   <%
   for (int i = 0; i < n; i++) { %>
      sessionStorage.setItem('dataListTs', '<%=list1.get(i).getTimestamp()%>');
      dataList_timestamp.push(sessionStorage.getItem('dataListTs'));
   <% } %>

    
/* n값과 n1 값도 바꿔오자 */    
   let n;
   let n1;
   sessionStorage.setItem('n', '<%=n%>');
   sessionStorage.setItem('n1', '<%=n1%>');
   n = sessionStorage.getItem('n');
   n1 = sessionStorage.getItem('n1')
   



   
   /* 빈 배열을 만들고 st1,2,3,4의 Y축 배열로 대입 */
      let st1_Arr = [];
      let sum1 = 0;      
      for (let i = 0; i < n; i++) {
           if (dataList[tem] == dataList_timestamp[i]) {
              st1_Arr.push(dataList_st1[i]);
           } 
         }
      
      let st2_Arr = [];
      let sum2 = 0;
      for (let i = 0; i < n; i++) {
           if (dataList[tem] == dataList_timestamp[i]) {
              st2_Arr.push(dataList_st2[i]);
           } 
         }
      
      let st3_Arr = [];
      let sum3 = 0;      
      for (let i = 0; i < n; i++) {
           if (dataList[tem] == dataList_timestamp[i]) {
              st3_Arr.push(dataList_st3[i]);
           } 
         }
      
      let st4_Arr = [];
      let sum4 = 0;
      for (let i = 0; i < n; i++) {
           if (dataList[tem] == dataList_timestamp[i]) {
              st4_Arr.push(dataList_st4[i]);
           } 
         }
      
      let sumArray = [];
      for (let i = 0; i < n; i++) {
          if (dataList[tem] == dataList_timestamp[i]) {
              let sum = parseInt(st1_Arr[i]) + parseInt(st2_Arr[i]) + parseInt(st3_Arr[i]) + parseInt(st4_Arr[i]);
              sumArray.push(sum);
          }
      }
      console.log("합친 배열 :", sumArray);
/*       
      let sum_st = [];      
      sum_st = st1_Arr.concat(st2_Arr, st3_Arr, st4_Arr);
      console.log("합친 배열 :"sum_st);
       */
      
/*    차트의 x축 배열값 */      
      let st_Arr2 = [];
      let kk = 2;
      for (let i = 0; i < n; i++) {
           if (dataList[tem] == dataList_timestamp[i]) {
              st_Arr2.push(kk);
              kk = kk + 2;
           } 
         }   
   
   

/* 날짜 조회 버튼을 눌렀을 때 상호작용 */
document.getElementById('submitButton').addEventListener('click', function() {
    let selectValue = document.getElementById('dates').value;
   
    st1_Arr = [];
    st2_Arr = [];
    st3_Arr = [];
    st4_Arr = [];
    st_Arr2 = [];
    sumArray = [];
    kk = 2;  // k값 초기화
    for (let i = 0; i < dataList.length; i++) {
        if (selectValue == dataList[i]) {
            tem = i;

            

            for (let j = 0; j < n; j++) {
                if (dataList[tem] == dataList_timestamp[j]) {
                    st1_Arr.push(dataList_st1[j]);
                    st2_Arr.push(dataList_st2[j]);
                    st3_Arr.push(dataList_st3[j]);
                    st4_Arr.push(dataList_st4[j]);
                    st_Arr2.push(kk);
                    kk = kk + 2;
                }
            }

          

        }
    }
    console.log("st1_Arr :", st1_Arr);
    console.log("st2_Arr :", st2_Arr);
    console.log("st3_Arr :", st3_Arr);
    console.log("st4_Arr :", st4_Arr);
    for (let j = 0; j < st1_Arr.length; j++) {
        
            let sum = parseInt(st1_Arr[j]) + parseInt(st2_Arr[j]) + parseInt(st3_Arr[j]) + parseInt(st4_Arr[j]);
            sumArray.push(sum);
            
    }
    console.log("sumArray: ", sumArray);
    

    spanElement = document.getElementById('search_date');
    newText = selectValue;
    // 텍스트 변경
    spanElement.innerHTML = newText;
    
    updateChart();
    updateChart3();
    
});





        function updateChart() {
   
           if (num === 1) {
                chartconfig = {
                    // num이 1일 때의 차트 설정
                    type: 'bar',
                    data: {                     
                        labels: st_Arr2,
                        datasets: [{
                            label: '<%=list2.get(0).getStt1()%>',
                            data: st1_Arr,
                            type: 'line',
                            fill: false,
                            backgroundColor: 'hsla(192, 95%, 50%, 1)',
                            borderColor: 'hsla(192, 95%, 50%, 1)',
                            borderWidth: 1
                        }]
                    }
                    
                /* 옵션으로 y축 값들을 입력하고 싶었지만 실패 */

                };
            } else if (num === 2) {
                chartconfig = {
                        // num이 2일 때의 차트 설정
                        type: 'bar',
                        data: {
                            labels: st_Arr2,
                            datasets: [{
                               label: '<%=list2.get(0).getStt2()%>',
                                data: st2_Arr,
                                type: 'line',
                                fill: false,
                                backgroundColor: 'hsla(22, 100%, 78%, 1)',
                                borderColor: 'hsla(22, 100%, 78%, 1)',
                                borderWidth: 1
                            }]
                        }
                    };
            } else if (num === 3) {
                chartconfig = {
                        // num이 3일 때의 차트 설정
                        type: 'bar',
                        data: {
                            labels: st_Arr2,
                            datasets: [{
                               label: '<%=list2.get(0).getStt3()%>',
                                data: st3_Arr,
                                type: 'line',
                                fill: false,
                                backgroundColor: 'hsla(145, 84%, 73%, 1)',
                                borderColor: 'hsla(145, 84%, 73%, 1)',
                                borderWidth: 1
                            }]
                        }
                    };
            } else if (num === 4) {
                chartconfig = {
                        // num이 4일 때의 차트 설정
                        type: 'bar',
                        data: {
                            labels: st_Arr2,
                            datasets: [{
                               label: '<%=list2.get(0).getStt4()%>',
                                data: st4_Arr,
                                type: 'line',
                                fill: false,
                                backgroundColor: 'hsla(270, 91%, 83%, 1)',
                                borderColor: 'hsla(270, 91%, 83%, 1)',
                                borderWidth: 1
                            }]
                        }
                    };
            } else {
                chartconfig = {
                    // num이 1이 아닐 때의 차트 설정
                    type: 'bar',
                    data: {
                        labels: st_Arr2,
                        datasets: [{
                            label: '학생 전체',
                            data: sumArray,
                            backgroundColor: 'hsla(311, 74%, 87%, 0.7)',    
                            borderColor: 'rgba(0, 0, 0, 0.5)',
                            borderWidth: 1
                        }, {
                            label: '<%=list2.get(0).getStt1()%>',
                            data: st1_Arr,
                            type: 'line',
                            fill: false,
                            backgroundColor: 'hsla(192, 95%, 50%, 1)',
                            borderColor: 'hsla(192, 95%, 50%, 1)',
                            borderWidth: 1
                        }, {
                            label: '<%=list2.get(0).getStt2()%>',
                            data: st2_Arr,
                            type: 'line',
                            fill: false,
                            backgroundColor: 'hsla(22, 100%, 78%, 1)',
                            borderColor: 'hsla(22, 100%, 78%, 1)',
                            borderWidth: 1
                        }, {
                            label: '<%=list2.get(0).getStt3()%>',
                            data: st3_Arr,
                            type: 'line',
                            fill: false,
                            backgroundColor: 'hsla(145, 84%, 73%, 1)',
                            borderColor: 'hsla(145, 84%, 73%, 1)',
                            borderWidth: 1
                        }, {
                            label: '<%=list2.get(0).getStt4()%>',
                            data: st4_Arr,
                            type: 'line',
                            fill: false,
                            backgroundColor: 'hsla(270, 91%, 83%, 1)',
                            borderColor: 'hsla(270, 91%, 83%, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: false,
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                };
            }

            // 기존 차트 객체를 파괴하고 새로운 차트를 생성하여 업데이트
            if (mixedChart) {
                mixedChart.destroy();
            }
            mixedChart = new Chart(ctx, chartconfig);
        }

        // 초기 차트 생성
        updateChart();
        


/* ---------------------------------------------------------------------------------------------------------------------------- */        
/* 좌측 하단 차트 만드는 부분 */        
   let chartconfig2;  
   let num2 = 1;

    const btn2_1 = document.getElementById('chartBtn2_1');
    const btn2_2 = document.getElementById('chartBtn2_2');
    const btn2_3 = document.getElementById('chartBtn2_3');
    const btn2_4 = document.getElementById('chartBtn2_4'); 
    let tem2 = 0;
    
    /* list_date.get(0) : 2023-12-19 */
    /* list_date_count.get(0) : 22개 */
    
    const ctx2 = document.getElementById('Chart2').getContext('2d');
    let Chart2;
   
    
    btn2_1.addEventListener('click', function() {
        num2 = 1; // num 값을 1로 변경
        updateChart2(); // updateChart 함수 호출
    });
    
    btn2_2.addEventListener('click', function() {
        num2 = 2; // num 값을 1로 변경
        updateChart2(); // updateChart 함수 호출
    });
    
    btn2_3.addEventListener('click', function() {
        num2 = 3; // num 값을 1로 변경
        updateChart2(); // updateChart 함수 호출
    });
    
    btn2_4.addEventListener('click', function() {
        num2 = 4; // num 값을 1로 변경
        updateChart2(); // updateChart 함수 호출
    });

/* 빈 배열을 만들고 st1,2,3,4의 Y축 배열로 대입 */
   let st1_Arr2 = [];
   for (let i = 0; i < dataList.length; i++) {
      let number = 0;
      let num_count = 0;
      for (let j = 0; j < n; j++) {
           if (dataList[i] == dataList_timestamp[j]) {
              number = number + parseInt(dataList_st1[j]);
              num_count = num_count + 1;
              } 
         }
      if (num_count == 0) {
         num_count = 1;
      }
      
      st1_Arr2.push(number/num_count);
      }   
   
   let st2_Arr2 = [];
   for (let i = 0; i < dataList.length; i++) {
      let number = 0;
      let num_count = 0;
      for (let j = 0; j < n; j++) {
           if (dataList[i] == dataList_timestamp[j]) {
              number = number + parseInt(dataList_st2[j]);
              num_count = num_count + 1;
              } 
         }
      if (num_count == 0) {
         num_count = 1;
      }
      
      st2_Arr2.push(number/num_count);
      }   
   
   let st3_Arr2 = [];
   for (let i = 0; i < dataList.length; i++) {
      let number = 0;
      let num_count = 0;
      for (let j = 0; j < n; j++) {
           if (dataList[i] == dataList_timestamp[j]) {
              number = number + parseInt(dataList_st3[j]);
              num_count = num_count + 1;
              } 
         }
      if (num_count == 0) {
         num_count = 1;
      }
      
      st3_Arr2.push(number/num_count);
      }   
   
   let st4_Arr2 = [];
   for (let i = 0; i < dataList.length; i++) {
      let number = 0;
      let num_count = 0;
      for (let j = 0; j < n; j++) {
           if (dataList[i] == dataList_timestamp[j]) {
              number = number + parseInt(dataList_st4[j]);
              num_count = num_count + 1;
              } 
         }
      if (num_count == 0) {
         num_count = 1;
      }
      
      st4_Arr2.push(number/num_count);
      }   
    
    
    

    function updateChart2() {
       
       if (num2 === 1) {
            chartconfig2 = {
                // num이 1일 때의 차트 설정
                type: 'bar',
                data: {                     
                    labels: dataList,
                    datasets: [{
                        label: '<%=list2.get(0).getStt1()%>',
                        data: st1_Arr2,
                        type: 'line',
                        fill: false,
                        backgroundColor: 'hsla(192, 95%, 50%, 1)',
                        borderColor: 'hsla(192, 95%, 50%, 1)',
                        borderWidth: 1
                    }]
                }
            };
        } else if (num2 === 2) {
            chartconfig2 = {
                    // num이 2일 때의 차트 설정
                    type: 'bar',
                    data: {
                        labels: dataList,
                        datasets: [{
                           label: '<%=list2.get(0).getStt2()%>',
                            data: st2_Arr2,
                            type: 'line',
                            fill: false,
                            backgroundColor: 'hsla(22, 100%, 78%, 1)',
                            borderColor: 'hsla(22, 100%, 78%, 1)',
                            borderWidth: 1
                        }]
                    }
                };
        } else if (num2 === 3) {
            chartconfig2 = {
                    // num이 3일 때의 차트 설정
                    type: 'bar',
                    data: {
                        labels: dataList,
                        datasets: [{
                           label: '<%=list2.get(0).getStt3()%>',
                            data: st3_Arr2,
                            type: 'line',
                            fill: false,
                            backgroundColor: 'hsla(145, 84%, 73%, 1)',
                            borderColor: 'hsla(145, 84%, 73%, 1)',
                            borderWidth: 1
                        }]
                    }
                };
        } else if (num2 === 4) {
            chartconfig2 = {
                    // num이 4일 때의 차트 설정
                    type: 'bar',
                    data: {
                        labels: dataList,
                        datasets: [{
                           label: '<%=list2.get(3).getStt4()%>',
                            data: st4_Arr2,
                            type: 'line',
                            fill: false,
                            backgroundColor: 'hsla(270, 91%, 83%, 1)',
                            borderColor: 'hsla(270, 91%, 83%, 1)',
                            borderWidth: 1
                        }]
                    }
                };
        } 

        // 기존 차트 객체를 파괴하고 새로운 차트를 생성하여 업데이트
        if (Chart2) {
            Chart2.destroy();
        }
        Chart2 = new Chart(ctx2, chartconfig2);
    }
    
    
    // 초기 차트 생성
    updateChart2();
    
/* 3번째 차트 생성 부분(차트) ---------------------------------------------------------------------------- */  

        let chartconfig3;
      
        /* list_date.get(0) : 2023-12-19 */
        /* list_date_count.get(0) : 22개 */
        
        const ctx3 = document.getElementById('Chart3').getContext('2d');
        let Chart3;

        function updateChart3() {
            let chartLabels = [];
            let chartData = [];
            let chartTitle = ''; // 차트 이름
         let sum_sleep = 0; // 졸음 합계      

            if (num === 1) {
               sum_sleep = st1_Arr.reduce((acc, currentValue) => acc + Number(currentValue), 0);               
               chartLabels = [`졸음 (${sum_sleep})`, "집중중"];                    
                chartData = [sum_sleep, st1_Arr.length - sum_sleep];
                chartTitle = '<%=list2.get(0).getStt1()%>'; // 제목 설정
            } else if (num === 2) {
               sum_sleep = st2_Arr.reduce((acc, currentValue) => acc + Number(currentValue), 0);
                chartLabels = ["졸음", "집중중"];
                chartData = [sum_sleep, st2_Arr.length - sum_sleep];
                chartTitle = '<%=list2.get(0).getStt2()%>'; // 제목 설정
            } else if (num === 3) {
               sum_sleep = st3_Arr.reduce((acc, currentValue) => acc + Number(currentValue), 0);
                chartLabels = ["졸음", "집중중"];
                chartData = [sum_sleep, st3_Arr.length - sum_sleep];
                chartTitle = '<%=list2.get(0).getStt3()%>'; // 제목 설정
            } else if (num === 4) {
               sum_sleep = st4_Arr.reduce((acc, currentValue) => acc + Number(currentValue), 0);
                chartLabels = ["졸음", "집중중"];
                chartData = [sum_sleep, st4_Arr.length - sum_sleep];
                chartTitle = '<%=list2.get(0).getStt4()%>'; // 제목 설정
            } else {
               sum_sleep = sumArray.reduce((acc, currentValue) => acc + Number(currentValue), 0);
                chartLabels = ["졸음", "집중중"];
                chartData = [sum_sleep, sumArray.length*4 - sum_sleep];  // 인원수가 4명이라 *4
                chartTitle = '전체'; // 제목 설정
            }

            if (chartData.length > 0) {
                chartconfig3 = {
                    type: 'pie',
                    data: {
                        labels: chartLabels,
                        datasets: [{
                            label: chartTitle,
                            data: chartData,
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.5)',
                                'rgba(54, 162, 235, 0.5)',
                                // 다른 색상 추가 가능
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                // 다른 색상 추가 가능
                            ],
                            borderWidth: 1
                        }]
                    },
                    options: {
                        plugins: {
                            legend: {
                                display: true,
                                position: 'top',
                            },
                            datalabels: {
                                color: '#fff',
                                anchor: 'end',
                                align: 'start'
                            }
                        },
                        title: {
                            display: true,
                            text: chartTitle // 여기에 제목 추가
                        }
                    }
                };
            }

            if (Chart3) {
                Chart3.destroy();
            }
            Chart3 = new Chart(ctx3, chartconfig3);
        }



        // 초기 차트 생성
        updateChart3();   
    
        

    </script>
	

    </body>
</html>