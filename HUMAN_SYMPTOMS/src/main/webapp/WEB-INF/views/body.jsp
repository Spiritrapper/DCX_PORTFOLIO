<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>건강 나침반</title>
<!-- css파일경로 입력 부분 -->
<link rel="stylesheet" href="assets/css/body.css" />
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/body_left.css" />
<link rel="stylesheet" href="assets/css/bodyicon.css" />
<script src="https://kit.fontawesome.com/8fba072206.js" crossorigin="anonymous"></script>
	
	<!-- 별떨어지는 애니메이션 css는 그냥 여기에 직접넣음 -->
	<style type="text/css">
body {
    background: radial-gradient(ellipse at bottom, #1b2735 0%, #090a0f 100%);

} 

/* #back_star {
    background: radial-gradient(ellipse at bottom, #1b2735 0%, #090a0f 100%);
    height: 100vh;
    overflow: hidden;
    display: flex;
    font-family: 'Anton', sans-serif;
    justify-content: center;
    align-items: center;
}
 */
.night {
    position: relative;
    width: 100%;
    height: 100%;
    transform: rotateZ(45deg);
    animation: sky 200000ms linear infinite;
}

.shooting_star {
    position: absolute;
    left: 50%;
    top: 50%;
    height: 2px;
    background: linear-gradient(-45deg, rgba(95, 145, 255, 1), rgba(0, 0, 255, 0));
    border-radius: 999px;
    filter: drop-shadow(0 0 6px rgba(105, 155, 255, 1));
    animation:
        tail 6000ms ease-in-out infinite,
        shooting 6000ms ease-in-out infinite;
}

.shooting_star::before {
    content: '';
    position: absolute;
    top: calc(50% - 1px);
    right: 0;
    height: 2px;
    background: linear-gradient(-45deg, rgba(0, 0, 255, 0), rgba(95, 145, 255, 1), rgba(0, 0, 255, 0));
    transform: translateX(50%) rotateZ(45deg);
    border-radius: 100%;
    animation: shining 3000ms ease-in-out infinite;
}

.shooting_star::after {
    content: '';
    position: absolute;
    top: calc(50% - 1px);
    right: 0;
    height: 2px;
    background: linear-gradient(-45deg, rgba(0, 0, 255, 0), rgba(95, 145, 255, 1), rgba(0, 0, 255, 0));
    transform: translateX(50%) rotateZ(-45deg);
    border-radius: 100%;
    animation: shining 3000ms ease-in-out infinite;
}

@keyframes tail {
    0% {
        width: 0;
    }
    30% {
        width: 80px;
    }
    100% {
        width: 0;
    }
}

@keyframes shining {
    0% {
        width: 0;
    }
    50% {
        width: 25px;
    }
    100% {
        width: 0;
    }
}

@keyframes shooting {
    0% {
        transform: translateX(-200px);
    }
    100% {
        transform: translateX(400px);
    }
}

@keyframes sky {
    0% {
        transform: rotate(45deg);
    }
    100% {
        transform: rotate(45 + 360deg);
    }
}
	
	</style>
</head>


<body>

	<div id="wrapper" style="background-image: none;">
		<div class="night" id="night">
            <!-- Stars will be added dynamically via JavaScript -->
        </div>
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
		
		
		<!-------------------- 여기서부터 container div-------------- -->

		<div class="container" >
		
		<!-- 왼쪽 팝업바 -->
		<ul id="nav_1" class="back_edit" style="height: 70%; width: 24%; background: none;">
			<div class="slider-container">
				
        		<span class="slider-leftBtn sliderBtn"></span>
        		<div class="card-container" id="slider">
        		<a href="https://nip.kdca.go.kr/irhp/covd/goErcprRegistInfo.do">
            		<div class="card" style="background-image: url('https://nip.kdca.go.kr/irhp/goBannerImage.do?seqnum=308&poptype=4');">
            		</div>
            	</a>
           		<div class="card">
           		<a href="https://nip.kdca.go.kr/irhp/infm/goVcntInfo.do?menuLv=1&menuCd=132">
               		<div class="card" style="background-image: url('https://nip.kdca.go.kr/irhp/goBannerImage.do?seqnum=335&poptype=4');">
            		</div>
            	</a>
            	</div>

            	<div class="card">
            	<a href="https://www.kdca.go.kr/board/board.es?mid=a20501000000&bid=0015&list_no=721889&act=view">
                	<div class="card" style="background-image: url('https://nip.kdca.go.kr/irhp/goBannerImage.do?seqnum=341&poptype=4');">
            		</div>
            	</a>
            	</div>
        </div>
        <span class="slider-rightBtn sliderBtn"></span>
    </div>
    
    <!-- <div>    
    <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
    &nbsp;&nbsp;&nbsp;
    <button id="btn_tsm">남성</button>
    &nbsp;&nbsp;&nbsp;&nbsp;
    <button id="btn_tsf">여성</button>
    </div> -->
    
	</ul>

			<!-- 선을 그리기 위한 캔버스 -->
			<canvas id="myCanvas"></canvas>
			<c:choose>
				<c:when test="${empty loginMember || gender.toString() eq 'M'}">
					<div class="human_model human_model_2">
						<c:set var="back_gender" value="male" />
						<img id="human_model" alt="" src="assets/images/사람모형(남자).png">
						
					</div>
				</c:when>
				<c:otherwise>
					<div class="human_model human_model_2">
						<c:set var="back_gender" value="female" />
						<img id="human_model" alt="" src="assets/images/사람모형(여자).png">
					</div>
				</c:otherwise>
			</c:choose>

			<!-- 머리 -->
			<form id=myForm1 action="disease">
				<div class="parts_light a" id="light1"></div>
				<div class="parts_light_div hidden" id="light_div1" style="z-index: 2;">
					<input type="hidden" name="dis_part" value="머리">
					<div class="symptom1 a" name="dis_symptom" data-symptom="어지러움">
						<div class="border_line1">
							<img id="symptom1_img1" class="symptom1_img1" alt="" width="30%"
								height="30%" src="assets/images/symptom/어지럼.png"> <span
								class="symptom_text"><strong>어지럼</strong><br>
							<span class="symptom_text1">머리가 어지럽고 <br>핑핑도네요
							</span></span>
						</div>
					</div>
					<div class="symptom1 b" name="dis_symptom" data-symptom="기억장애">
						<div class="border_line1">
							<img id="symptom1_img2" class="symptom_img symptom1_img2" alt=""
								width="30%" height="30%" src="assets/images/symptom/치매.png">
							<span class="symptom_text"><strong>기억장애</strong><br>자꾸
								어제있던일을 <br>까먹네 
						</div>
					</div>
					<div class="symptom1 c" name="dis_symptom" data-symptom="머리에서 열이 남">
						<div class="border_line1">
							<img id="symptom1_img3" class="symptom_img symptom1_img3" alt=""
								width="29%" height="29%" src="assets/images/symptom/fever.png">
							<span class="symptom_text"><strong>열이 남</strong><br>머리에서
								열이나네<br>
						</div>
					</div>
				</div>
			</form>
			<!-- 복부부분 -->
			<form id=myForm2 action="disease">
				<div class="parts_light b" id="light2"></div>
				<div class="parts_light_div hidden" id="light_div2" style="z-index: 3;">
					<input type="hidden" name="dis_part" value="복부">
					
					<div class="symptom2 a" name="dis_symptom" data-symptom="속쓰림">
						<div class="border_line1">
							<img id="symptom2_img1" alt="" width="30%" height="30%"
								src="assets/images/symptom/속쓰림.png"> <span
								class="symptom_text"><strong>속쓰림</strong><br>배가 계속
								쓰리고<br>통증이 있습니다. 
						</div>
					</div>
					<div class="symptom2 b" name="dis_symptom" data-symptom="배 부풀어오름">
						<div class="border_line1">
							<img id="symptom2_img2" alt="" width="30%" height="30%"
								src="assets/images/symptom/배부풀어오름1.png"> <span
								class="symptom_text"><strong>복부 팽창</strong><br>배가
								더부룩하고<br>풍선같이 팽창되있어요 
						</div>
					</div>
					
				</div>
			</form>
			<!-- 팔꿈치 -->
			<form id=myForm3 action="disease">
				<div class="parts_light c" id="light3"></div>
				<div class="parts_light_div hidden" id="light_div3" style="z-index: 4;">
					<input type="hidden" name="dis_part" value="팔">
					<div class="symptom3 a" name="dis_symptom" data-symptom="팔꿈치 통증">
						<div class="border_line1">
							<img id="symptom3_img1" alt="" width="30%" height="30%"
								src="assets/images/symptom/팔꿈치1.png"> <span
								class="symptom_text"><strong>팔꿈치통증</strong><br>팔꿈치가
								찌릿하고<br>아픕니다. 
						</div>
					</div>
					<div class="symptom3 b" name="dis_symptom" data-symptom="손 저림">
						<div class="border_line1">
							<img id="symptom3_img2" alt="" width="30%" height="30%"
								src="assets/images/symptom/손저림.png"> <span
								class="symptom_text"><strong>손저림</strong><br>손이 자꾸
								떨리고<br>찌릿찌릿 저리네요. 
						</div>
					</div>
				</div>
			</form>
			<!-- 무릎 -->
			<form id=myForm4 action="disease">
				<div class="parts_light d" id="light4"></div>
				<div class="parts_light_div hidden" id="light_div4" style="z-index: 5;">
					<input type="hidden" name="dis_part" value="무릎/다리">
					<div class="symptom4 a" name="dis_symptom" data-symptom="무릎 붓기">
						<div class="border_line1">
							<img id="symptom4_img1" alt="" width="30%" height="30%"
								src="assets/images/symptom/무릎symptoms.png"> <span
								class="symptom_text"><strong>무릎붓기</strong><br>무릎이
								굽히기 불편하게<br>퉁퉁 부었어요. 
						</div>
					</div>
					<div class="symptom4 b" name="dis_symptom" data-symptom="다리 붓기">
						<div class="border_line1">
							<img id="symptom4_img2" alt="" width="30%" height="30%"
								src="assets/images/symptom/다리붓기.png"> <span
								class="symptom_text"><strong>다리붓기</strong><br>다리가
								퉁퉁 부었어요.<br>
						</div>
					</div>
				</div>
			</form>
			<!-- 목 -->
			<form id=myForm5 action="disease">
				<div class="parts_light e" id="light5"></div>
				<div class="parts_light_div hidden" id="light_div5"
					style="z-index: 2;">
					<input type="hidden" name="dis_part" value="목">
					<div class="symptom5 a" name="dis_symptom" data-symptom="목뻐근함">
						<div class="border_line1">
							<img id="symptom5_img1" alt="" width="30%" height="30%"
								src="assets/images/symptom/목뻐근함2.png"> <span
								class="symptom_text"><strong>목뻐근함</strong><br>목을
								가누기 힘들게<br>뻐근하고 땡기네요. 
						</div>
					</div>
					<div class="symptom5 b" name="dis_symptom" data-symptom="목소리쉼">
						<div class="border_line1">
							<img id="symptom5_img2" alt="" width="30%" height="30%"
								src="assets/images/symptom/쉰목소리3.png"> <span
								class="symptom_text"><strong>쉰목소리</strong><br>평소와
								다르게<br>목소리가 거칠어요. 
						</div>
					</div>
				</div>
			</form>
			<!-- 가슴 -->
			<form id=myForm6 action="disease">
				<div class="parts_light f" id="light6"></div>
				<div class="parts_light_div hidden light_div6_1" id="light_div6" style="z-index: 3;">
					<input type="hidden" name="dis_part" value="가슴">
					<c:choose>
						<c:when test="${empty loginMember || gender.toString() eq 'M'}">
							<div class="symptom6 a" name="dis_symptom"
								data-symptom="가슴 압박/통증">
								<div class="border_line1">
									<img id="symptom6_img1" alt="" width="30%" height="30%"
										src="assets/images/symptom/가슴압박2.png"> <span
										class="symptom_text"><strong>압박/통증</strong><br>가슴이
										답답하고<br>아파요. 
								</div>
							</div>

							<div class="symptom6 b" name="dis_symptom" data-symptom="가슴 두근거림">
								<div class="border_line1">
									<img id="symptom6_img2" alt="" width="30%" height="30%"
										src="assets/images/symptom/가슴압박1.png"> <span
										class="symptom_text"><strong>두근거림</strong><br>심장이
										두근거리고<br>숨이가빠요. 
								</div>
							</div>
						</c:when>
							
						<c:otherwise>
							<div class="symptom6 a" name="dis_symptom"
								data-symptom="가슴 압박/통증">
								<div class="border_line1">
									<img id="symptom6_img1" alt="" width="30%" height="30%"
										src="assets/images/symptom/여성가슴압박.png"> <span
										class="symptom_text"><strong>압박/통증</strong><br>가슴이
										답답하고<br>아파요. 
								</div>
							</div>

							<div class="symptom6 b" name="dis_symptom"
								data-symptom="가슴 통증/몽울">
								<div class="border_line1">
									<img id="symptom6_img2" alt="" width="30%" height="30%"
										src="assets/images/symptom/유방암.png"> <span
										class="symptom_text"><strong>통증/몽울</strong><br>가슴에
										딱딱한<br>몽울이잡히고 아파요. 
								</div>
							</div>			
						</c:otherwise>
					</c:choose>
		
				</div>
			</form>
			<!-- 비뇨생식기 -->
			<form id=myForm7 action="disease">
				<div class="parts_light g" id="light7"></div>
				<div class="parts_light_div hidden light_div7_1" id="light_div7" style="z-index: 3;">
					<input type="hidden" name="dis_part" value="비뇨생식기">
					<c:choose>
						<c:when test="${empty loginMember || gender.toString() eq 'M'}">
							<div class="symptom7 a" name="dis_symptom" data-symptom="배뇨장애">
							<div class="border_line1">
								<img id="symptom7_img1" alt="" width="30%" height="30%"
									src="assets/images/symptom/배뇨incontinence.png"> <span
									class="symptom_text"><strong>배뇨장애</strong><br>화장실을
									<br>자주가게 되네요. 
							</div>
							</div>

							<div class="symptom7 b" name="dis_symptom" data-symptom="성기능장애">
								<div class="border_line1">
									<img id="symptom7_img2" alt="" width="30%" height="30%"
										src="assets/images/symptom/발기부전.png"> <span
										class="symptom_text"><strong>발기 부전</strong><br>어제밤이
										잠자리가<br>예전같지 않아요. 
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="symptom7 a" name="dis_symptom" data-symptom="배뇨장애">
							<div class="border_line1">
								<img id="symptom7_img1" alt="" width="30%" height="30%"
									src="assets/images/symptom/배뇨incontinence.png"> <span
									class="symptom_text"><strong>배뇨장애</strong><br>화장실을
									<br>자주가게 되네요. 
							</div>
							</div>
							<div class="symptom7 b" name="dis_symptom" data-symptom="생리불순">
								<div class="border_line1">
									<img id="symptom7_img2" alt="" width="30%" height="30%"
										src="assets/images/symptom/생리불순.png"> <span
										class="symptom_text"><strong>생리불순</strong><br>오늘이
										그날인데....<br>
							</div>
						</div>			
						</c:otherwise>
					</c:choose>								
				</div>
			</form>
			<!-- 발 -->
			<form id=myForm8 action="disease">
				<div class="parts_light h" id="light8"></div>
				<div class="parts_light_div hidden" id="light_div8"
					style="z-index: 3;">
					<input type="hidden" name="dis_part" value="발">
					<div class="symptom8 a" name="dis_symptom" data-symptom="발목기능장애">
						<div class="border_line1">
							<img id="symptom8_img1" alt="" width="30%" height="30%"
								src="assets/images/symptom/발목통증.png"> <span
								class="symptom_text"><strong>발목통증</strong><br>발목이
								아프고<br>움직이기 힘들어요. 
						</div>
					</div>
					<div class="symptom8 b" name="dis_symptom" data-symptom="발붓기">
						<div class="border_line1">
							<img id="symptom8_img2" alt="" width="30%" height="30%"
								src="assets/images/symptom/발붓기.png"> <span
								class="symptom_text"><strong>발붓기</strong><br>발이 퉁퉁<br>부었어요.
						
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- container 끝 -->



	<!-- 문서 로드시 불러와야 하는 스크립트들 -->
	<script>
		/* 문서가 로드될 때, adjustHeadLightPosition 함수 호출 */
		document.addEventListener('DOMContentLoaded', function() {
			adjustHeadLightPosition();
		});

		/* 문서가 로드될 때, adjustHeadLightPositionDiv 함수 호출 */
		document.addEventListener('DOMContentLoaded', function() {
			adjustHeadLightPositionDiv();
		});

		/* 문서가 로드될 때, adjustHeadLightPosition2 함수 호출 */
		document.addEventListener('DOMContentLoaded', function() {
			adjustHeadLightPosition2();
		});

		/* 문서가 로드될 때, adjustHeadLightPositionDiv2 함수 호출 */
		document.addEventListener('DOMContentLoaded', function() {
			adjustHeadLightPositionDiv2();
		});

		/* 3 함수 호출 */
		document.addEventListener('DOMContentLoaded', function() {
			adjustHeadLightPosition3();
		});

		/* 3 함수 호출 */
		document.addEventListener('DOMContentLoaded', function() {
			adjustHeadLightPositionDiv3();
		});

		/* 4 함수 호출 */
		document.addEventListener('DOMContentLoaded', function() {
			adjustHeadLightPosition4();
		});

		/* 4 함수 호출 */
		document.addEventListener('DOMContentLoaded', function() {
			adjustHeadLightPositionDiv4();
		});

		/* 5 함수 호출 */
		document.addEventListener('DOMContentLoaded', function() {
			adjustHeadLightPosition5();
		});

		/* 5 함수 호출 */
		document.addEventListener('DOMContentLoaded', function() {
			adjustHeadLightPositionDiv5();
		});

		/* 6 함수 호출 */
		document.addEventListener('DOMContentLoaded', function() {
			adjustHeadLightPosition6();
		});

		/* 6 함수 호출 */
		document.addEventListener('DOMContentLoaded', function() {
			adjustHeadLightPositionDiv6();
		});

		/* 7 함수 호출 */
		document.addEventListener('DOMContentLoaded', function() {
			adjustHeadLightPosition7();
		});

		/* 7 함수 호출 */
		document.addEventListener('DOMContentLoaded', function() {
			adjustHeadLightPositionDiv7();
		});

		/* 8 함수 호출 */
		document.addEventListener('DOMContentLoaded', function() {
			adjustHeadLightPosition7();
		});

		/* 8 함수 호출 */
		document.addEventListener('DOMContentLoaded', function() {
			adjustHeadLightPositionDiv7();
		});
		
		
		/* 여기부터는 왼쪽 팝업창 관련 js */
		
	let leftBtn = [...document.getElementsByClassName("slider-leftBtn")]
    let rightBtn = [...document.getElementsByClassName("slider-rightBtn")]
    let slider = [...document.querySelectorAll(".card-container")]
    let sliderDimension = document.querySelector(".card-container")


    slider.forEach((item, i) => {
        let containerDimension = item.getBoundingClientRect().width;
        if ((item.childElementCount * 350) < (containerDimension + 100)) {
            rightBtn[i].style.display = 'none';
            leftBtn[i].style.display = 'none';
            item.style.justifyContent = 'space-around';
        }
        leftBtn[i].style.display = "none"
        rightBtn[i].addEventListener('click', () => {
            item.scrollLeft += containerDimension;
            leftBtn[i].style.display = 'block';
        })
        leftBtn[i].addEventListener('click', () => {
            item.scrollLeft -= containerDimension;
            rightBtn[i].style.display = 'block';
        })
        item.addEventListener('scroll', () => {
            if (item.offsetWidth + item.scrollLeft >= (item.scrollWidth - 100)) {
                rightBtn[i].style.display = 'none';
                leftBtn[i].style.display = 'block';
            } else if (item.scrollLeft == 0) {
                leftBtn[i].style.display = 'none';
                rightBtn[i].style.display = 'block';
            } else if (item.scrollLeft > 0) {
                leftBtn[i].style.display = 'block';
            }
            if (item.offsetWidth + item.scrollLeft < (item.scrollWidth - 50)) {
                rightBtn[i].style.display = 'block';
            }
        })

        const slidingFunction = () => {
            if (item.offsetWidth + item.scrollLeft >= (item.scrollWidth - 100)) {
                // item.style.scrollBehavior = "auto";
                item.scrollLeft = 0;
            }
            if (item.offsetWidth + item.scrollLeft < (item.scrollWidth - 50)) {
                // item.style.scrollBehavior = "smooth";
                item.scrollLeft += containerDimension;
            }
        }

        setInterval(() => slidingFunction(), 10000)
    })
    
    
    /* 여기서부터는 배경 별똥별 */
const night = document.getElementById("night");
const shootingTime = 100; // Define the shooting time here

for (let i = 0; i < 15; i++) {
    const shootingStar = document.createElement("div");
    shootingStar.classList.add("shooting_star");

    const delay = Math.floor(Math.random() * 20000) + "ms";
    const leftPosition = Math.random() * window.innerWidth + "px";
    const topPosition = Math.random() * window.innerHeight + "px";
    
    shootingStar.style.animationDelay = delay;
    shootingStar.style.top = topPosition;
    shootingStar.style.left = leftPosition;

    night.appendChild(shootingStar);
}

/* 성별 전환 버튼 */
const btn_tsm = document.getElementById('btn_tsm'); // 남성변환 버튼
const btn_tsf = document.getElementById('btn_tsf'); // 여성변환 버튼
const light_div6_1 = document.querySelector('.light_div6_1'); // 가슴 div
const light_div7_1 = document.querySelector('.light_div7_1'); // 비뇨생식기 div
const human_model_2 = document.querySelector('.human_model_2');

// 남성변환 버튼이 클릭되었을 때 실행할 코드
btn_tsm.addEventListener('click', function() {
   
    light_div6_1.innerHTML = `
        <input type="hidden" name="dis_part" value="가슴">가슴
        <div class="symptom6 a" name="dis_symptom"
			data-symptom="가슴 압박/통증">
			<div class="border_line1">
				<img id="symptom6_img1" alt="" width="30%" height="30%"
					src="assets/images/symptom/가슴압박2.png"> <span
					class="symptom_text"><strong>압박/통증</strong><br>가슴이
					답답하고<br>아파요. 
			</div>
		</div>

		<div class="symptom6 b" name="dis_symptom" data-symptom="가슴 두근거림">
			<div class="border_line1">
				<img id="symptom6_img2" alt="" width="30%" height="30%"
					src="assets/images/symptom/가슴압박1.png"> <span
					class="symptom_text"><strong>두근거림</strong><br>심장이
					두근거리고<br>숨이가빠요. 
			</div>
		</div>
    `;
    light_div7_1.innerHTML = `
        <input type="hidden" name="dis_part" value="비뇨생식기">비뇨생식기
        <div class="symptom7 a" name="dis_symptom" data-symptom="배뇨장애">
		<div class="border_line1">
			<img id="symptom7_img1" alt="" width="30%" height="30%"
				src="assets/images/symptom/배뇨incontinence.png"> <span
				class="symptom_text"><strong>배뇨장애</strong><br>화장실을
				<br>자주가게 되네요. 
		</div>

		<div class="symptom7 b" name="dis_symptom" data-symptom="발기 부전">
			<div class="border_line1">
				<img id="symptom7_img2" alt="" width="30%" height="30%"
					src="assets/images/symptom/발기부전.png"> <span
					class="symptom_text"><strong>성기능저하</strong><br>어제밤이
					잠자리가<br>예전같지 않아요. 
			</div>
		</div>
	</div>
    `;
    
    human_model_2.innerHTML = `
    	<img id="human_model" alt="" src="assets/images/사람모형(남자).png">
    `;
});


//여성변환 버튼이 클릭되었을 때 실행할 코드
btn_tsf.addEventListener('click', function() {
   
    light_div6_1.innerHTML = `
    	<input type="hidden" name="dis_part" value="가슴">가슴
    	<div class="symptom6 a" name="dis_symptom"
			data-symptom="가슴 압박/통증">
			<div class="border_line1">
				<img id="symptom6_img1" alt="" width="30%" height="30%"
					src="assets/images/symptom/여성가슴압박.png"> <span
					class="symptom_text"><strong>압박/통증</strong><br>가슴이
					답답하고<br>아파요. 
			</div>
		</div>

		<div class="symptom6 b" name="dis_symptom"
			data-symptom="가슴 통증/몽울">
			<div class="border_line1">
				<img id="symptom6_img2" alt="" width="30%" height="30%"
					src="assets/images/symptom/유방암.png"> <span
					class="symptom_text"><strong>통증/몽울</strong><br>가슴에
					딱딱한<br>몽울이잡히고 아파요. 
			</div>
		</div>
    `;
    light_div7_1.innerHTML = `
        <input type="hidden" name="dis_part" value="비뇨생식기">비뇨생식기
        <div class="symptom7 a" name="dis_symptom" data-symptom="배뇨장애">
		<div class="border_line1">
			<img id="symptom7_img1" alt="" width="30%" height="30%"
				src="assets/images/symptom/배뇨incontinence.png"> <span
				class="symptom_text"><strong>배뇨장애</strong><br>화장실을
				<br>자주가게 되네요. 
		</div>

		<div class="symptom7 b" name="dis_symptom" data-symptom="생리불순">
			<div class="border_line1">
				<img id="symptom7_img2" alt="" width="30%" height="30%"
					src="assets/images/symptom/생리불순.png"> <span
					class="symptom_text"><strong>생리불순</strong><br>오늘이
					그날인데....<br>
			</div>
		</div>
	</div>	
    `;
    
    human_model_2.innerHTML = `
    	<img id="human_model" alt="" src="assets/images/사람모형(여자).png">
    `;
});

    
	</script>



	<!-- js파일경로 입력 부분 -->
	<script src="assets/js/body.js"></script>
	<script src="assets/js/body2.js"></script>
	<script>
		const board = document.querySelector('#board');
		
		board.addEventListener('click',()=>{
			alert('게시판은 로그인 후에 이용할 수 있습니다');
		});
	</script>
</body>
</html>