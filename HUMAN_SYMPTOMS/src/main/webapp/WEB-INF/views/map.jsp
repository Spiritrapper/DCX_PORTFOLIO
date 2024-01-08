<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>건강 나침반</title>
<script src="https://kit.fontawesome.com/8fba072206.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="assets/css/main.css" />
<style>
#category {position:absolute;top:10px;left:10px; font-size:xx-small; border-radius: 5px; border:1px solid #ebebeb;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);background: #ebebeb;overflow: hidden;z-index: 2;}
#category li {float:left;list-style: none;width:50px;px;border-right:1px solid #acacac;padding:6px 0;text-align: center; cursor: pointer;}
#category li.on {background: #eee;}
#category li:hover {background: #ffe6e6;border-left:1px solid #acacac;margin-left: -1px;}
#category li:last-child{margin-right:0;border-right:0;}
#category li span {display: block;margin:0 auto 3px;width:27px;height: 28px;}
#category li .bank {background-position: -7px 0;}
#category li .mart {background-position: -7px -36px;}
#category li .pharmacy {background-position: -7px -72px;}
#category li .oil {background-position: -7px -108px;}
#category li .cafe {background-position: -7px -144px;}
#category li .store {background-position: -7px -180px;}
#category li.on .category_bg {background-position-x:-9px;}
.placeinfo_wrap {position:absolute;bottom:28px;left:-150px;width:300px;}
.placeinfo {position:relative;width:100%;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;padding-bottom: 10px;background: #fff;}
.placeinfo:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.placeinfo_wrap .after {content:'';position:relative;margin-left:-12px;left:50%;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
.placeinfo a, .placeinfo a:hover, .placeinfo a:active{color:#fff;text-decoration: none;}
.placeinfo a, .placeinfo span {display: block;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
.placeinfo span {margin:5px 5px 0 5px;cursor: default;font-size:13px;}
.placeinfo .title {font-weight: bold; font-size:14px;border-radius: 6px 6px 0 0;margin: -1px -1px 0 -1px;padding:10px; color: #fff;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.placeinfo .tel {color:#0f7833;}
.placeinfo .jibun {color:#999;font-size:11px;margin-top:0;}
</style>
</head>
<body>
<body class="is-preload">
	<!-- Wrapper -->
	<div id="wrapper">
		<nav class="navbar">
         <div class="navbar_logo">
            <a href="/bigdata" style="color: white;"><img src="assets/images/betterhealth.png" width=30px" height="30px"> 건강 나침반</a>
         </div>

		<ul class="navbar_menu">
			<%  %>
			<% if(session.getAttribute("loginMember")==null){ %>
			
				<li><a id="board" href="/bigdata/board" style="color: white; padding: 0px;">게시판</a></li>
				<li><a href="/bigdata/" style="color: white; padding: 0px;">질병/질환</a></li>
				<li><a href="/bigdata/map" style="color: white; padding: 0px;">병원 찾기</a></li>
				<li><a href="/bigdata/login" style="color: white; padding: 0px;">로그인</a></li>
				<%} else {%>
				
			
    <li><a href="/bigdata/board" style="color: white; padding: 0px;">게시판</a></li>
    <li><a href="/bigdata/" style="color: white; padding: 0px;">질병/질환</a></li>
    <li><a href="/bigdata/map" style="color: white; padding: 0px;">병원 찾기</a></li>
    <li><a href="/bigdata/member/logout" style="color: white; padding: 0px;">로그아웃</a></li>
<%} %>
		</ul>
		
		<%-- 
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
		 --%>

         <ul class="navbar_icons">
            
         </ul>
       
      </nav>
		
		<div class="map_wrap" style="margin-top: 20px">
			<div id="menu_wrap" class="bg_white">
				<div class="option">
					<div style="text-align: center; margin-bottom: 5px;">
						<input type="text" id="keyword" size="15" placeholder="위치 입력" value="이수역" style="display: inline; width: 200px" autocomplete="off">
					</div>
				</div>
			</div>
			<div style="background-color: white; width: 400px; height: 550px; display: block; position: relative; left: -200px; overflow: auto;">
    			<div style="margin: 10px;">
        			<ul id="placesList" style="background-color: white;"></ul>
        			<div id="pagination" style="text-align: center; background-color: yellow;"></div>
        		</div>
			</div>
			<div id="map" style="width: 800px; height: 550px; display: block; position:relative; left:200px; top:-550px">
				<form onsubmit="searchPlaces(); return false;">
					<ul id="category">
				        <li id="BK9" data-order="0" value="비뇨기과" class="on"> 
				            <span class="category_bg bank"></span>
				            비뇨기과
				        </li>       
				        <li id="MT1" data-order="1" value="정형외과"> 
				            <span class="category_bg mart"></span>
				            정형외과
				        </li>  
				        <li id="PM9" data-order="2" value="내과"> 
				            <span class="category_bg pharmacy"></span>
				            내과
				        </li>  
				        <li id="OL7" data-order="3" value="외과"> 
				            <span class="category_bg oil"></span>
				            외과
				        </li>  
				        <li id="CE7" data-order="4" value="재활의학과"> 
				            <span class="category_bg cafe"></span>
				            재활의학과
				        </li>  
				        <li id="CS2" data-order="5" value="산부인과"> 
				            <span class="category_bg store"></span>
				            산부인과
				        </li>
					</ul>
				</form>
			</div>
		</div>
	</div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3e5675dfc548fbc2868b025654ea04b5&libraries=services&libraries=services"></script>
	<script>
		// 마커를 담을 배열입니다
		var markers = [];

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.48541924304421,
					126.98215792656391), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places();

		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
			zIndex : 1
		});

		// 키워드로 장소를 검색합니다
		searchPlaces();

		// 키워드 검색을 요청하는 함수입니다
		function searchPlaces() {

			var keyword = document.getElementById('keyword').value;
			var keyword2 = document.querySelector('li.on').getAttribute('value');
			var search = keyword + keyword2;

			// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
			ps.keywordSearch(search, placesSearchCB);
		}

		// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
			if (status === kakao.maps.services.Status.OK) {

				// 정상적으로 검색이 완료됐으면
				// 검색 목록과 마커를 표출합니다
				displayPlaces(data);

				// 페이지 번호를 표출합니다
				displayPagination(pagination);

			} else if (status === kakao.maps.services.Status.ZERO_RESULT) {

				alert('검색 결과가 존재하지 않습니다.');
				return;

			} else if (status === kakao.maps.services.Status.ERROR) {

				alert('검색 결과 중 오류가 발생했습니다.');
				return;

			}
		}

		// 검색 결과 목록과 마커를 표출하는 함수입니다
		function displayPlaces(places) {

			var listEl = document.getElementById('placesList'), menuEl = document
					.getElementById('menu_wrap'), fragment = document
					.createDocumentFragment(), bounds = new kakao.maps.LatLngBounds(), listStr = '';

			// 검색 결과 목록에 추가된 항목들을 제거합니다
			removeAllChildNods(listEl);

			// 지도에 표시되고 있는 마커를 제거합니다
			removeMarker();

			for (var i = 0; i < places.length; i++) {

				// 마커를 생성하고 지도에 표시합니다
				var placePosition = new kakao.maps.LatLng(places[i].y,
						places[i].x), marker = addMarker(placePosition, i), itemEl = getListItem(
						i, places[i]); // 검색 결과 항목 Element를 생성합니다

				// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
				// LatLngBounds 객체에 좌표를 추가합니다
				bounds.extend(placePosition);

				// 마커와 검색결과 항목에 mouseover 했을때
				// 해당 장소에 인포윈도우에 장소명을 표시합니다
				// mouseout 했을 때는 인포윈도우를 닫습니다
				(function(marker, title) {
					kakao.maps.event.addListener(marker, 'mouseover',
							function() {
								displayInfowindow(marker, title);
							});

					kakao.maps.event.addListener(marker, 'mouseout',
							function() {
								infowindow.close();
							});

					itemEl.onmouseover = function() {
						displayInfowindow(marker, title);
					};

					itemEl.onmouseout = function() {
						infowindow.close();
					};
				})(marker, places[i].place_name);

				fragment.appendChild(itemEl);
			}

			// 검색결과 항목들을 검색결과 목록 Element에 추가합니다
			listEl.appendChild(fragment);
			menuEl.scrollTop = 0;

			// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			map.setBounds(bounds);
		}

		// 검색결과 항목을 Element로 반환하는 함수입니다
		function getListItem(index, places) {

			var el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
					+ (index + 1)
					+ '"></span>'
					+ '<div class="info">'
					+ '   <h5>' + places.place_name + '</h5>';

			if (places.road_address_name) {
				itemStr += '    <span>' + places.road_address_name + '</span>'
						+ '   <span class="jibun gray">' + places.address_name
						+ '</span>';
			} else {
				itemStr += '    <span>' + places.address_name + '</span>';
			}

			itemStr += '  <span class="tel">' + places.phone + '</span>'
					+ '</div>';

			el.innerHTML = itemStr;
			el.className = 'item';

			return el;
		}

		// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
		function addMarker(position, idx, title) {
			var imageSrc = 'assets/images/marker15.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
			imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
			imgOptions = {
				spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
				spriteOrigin : new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
				offset : new kakao.maps.Point(13, 37)
			// 마커 좌표에 일치시킬 이미지 내에서의 좌표
			}, markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
					imgOptions), marker = new kakao.maps.Marker({
				position : position, // 마커의 위치
				image : markerImage
			});

			marker.setMap(map); // 지도 위에 마커를 표출합니다
			markers.push(marker); // 배열에 생성된 마커를 추가합니다

			return marker;
		}

		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
		function removeMarker() {
			for (var i = 0; i < markers.length; i++) {
				markers[i].setMap(null);
			}
			markers = [];
		}

		// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
		function displayPagination(pagination) {
			var paginationEl = document.getElementById('pagination'), fragment = document
					.createDocumentFragment(), i;

			// 기존에 추가된 페이지번호를 삭제합니다
			while (paginationEl.hasChildNodes()) {
				paginationEl.removeChild(paginationEl.lastChild);
			}

			for (i = 1; i <= pagination.last; i++) {
				var el = document.createElement('a');
				el.href = "#";
				el.innerHTML = i;

				if (i === pagination.current) {
					el.className = 'on';
				} else {
					el.onclick = (function(i) {
						return function() {
							pagination.gotoPage(i);
						}
					})(i);
				}

				fragment.appendChild(el);
			}
			paginationEl.appendChild(fragment);
		}

		// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
		// 인포윈도우에 장소명을 표시합니다
		function displayInfowindow(marker, title) {
			var content = '<div style="padding:5px;z-index:1;">' + title
					+ '</div>';

			infowindow.setContent(content);
			infowindow.open(map, marker);
		}

		// 검색결과 목록의 자식 Element를 제거하는 함수입니다
		function removeAllChildNods(el) {
			while (el.hasChildNodes()) {
				el.removeChild(el.lastChild);
			}
		}
		
		// 추가
		
		var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}), 
		    contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
		    markers = [], // 마커를 담을 배열입니다
		    currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
		
		// 각 카테고리에 클릭 이벤트를 등록합니다
		addCategoryClickEvent();
		
		// 각 카테고리에 클릭 이벤트를 등록합니다
		function addCategoryClickEvent() {
		    var category = document.getElementById('category'),
		        children = category.children;

		    for (var i=0; i<children.length; i++) {
		        children[i].onclick = onClickCategory;
		    }
		}

		// 카테고리를 클릭했을 때 호출되는 함수입니다
		function onClickCategory() {
		    var id = this.id,
		        className = this.className;

		    placeOverlay.setMap(null);

		    if (className === 'on') {
		        currCategory = '';
		        changeCategoryClass();
		        removeMarker();
		    } else {
		        currCategory = id;
		        changeCategoryClass(this);
		        searchPlaces();
		    }
		}
		
		// 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
		function changeCategoryClass(el) {
		    var category = document.getElementById('category'),
		        children = category.children,
		        i;

		    for ( i=0; i<children.length; i++ ) {
		        children[i].className = '';
		    }

		    if (el) {
		        el.className = 'on';
		    } 
		} 
	</script>
	<script>
		const board = document.querySelector('#board');
		
		board.addEventListener('click',()=>{
			alert('게시판은 로그인 후에 이용할 수 있습니다');
		});
	</script>
</body>
</html>