/* 부위에 따른 넘버링*/
/*
머리 : 1 (주의할 점 : 3개의 함수중, font함수를 제외한 앞에 두 함수는 넘버링이 붙지 않음)
장 : 2


*/

/* 이미지를 클릭했을 때 상호작용*/

/*위에서 전역변수로 안불러온거 후회하는중*/

/*이미지들 다 불러옴*/
var light1 = document.getElementById('light1');
var light2 = document.getElementById('light2');
var light3 = document.getElementById('light3');
var light4 = document.getElementById('light4');
var light5 = document.getElementById('light5');
var light6 = document.getElementById('light6');
var light7 = document.getElementById('light7');
var light8 = document.getElementById('light8');

/*간단한 정보를 제공해주는 div들 다 불러옴*/
var light_div1 = document.getElementById('light_div1');
var light_div2 = document.getElementById('light_div2');
var light_div3 = document.getElementById('light_div3');
var light_div4 = document.getElementById('light_div4');
var light_div5 = document.getElementById('light_div5');
var light_div6 = document.getElementById('light_div6');
var light_div7 = document.getElementById('light_div7');
var light_div8 = document.getElementById('light_div8');






/* ----------------캔버스로 선을 그리는 코드----------------- 열심히 만들었지만... 일단 사용안하기로 결정*/

var canvas = document.getElementById('myCanvas');
var ctx = canvas.getContext('2d');

// 선 8개에 대한 좌표값
var lines = [
	{ startX: 0.26, startY: 0.08, endX: 0.51, endY: 0.30 },
	{ startX: 0.26, startY: 0.415, endX: 0.51, endY: 0.30 },
	{ startX: 0.20, startY: 0.41, endX: 0.51, endY: 0.30 },
	{ startX: 0.235, startY: 0.72, endX: 0.51, endY: 0.30 },
	{ startX: 0.26, startY: 0.17, endX: 0.51, endY: 0.30 },
	{ startX: 0.28, startY: 0.32, endX: 0.51, endY: 0.30 },
	{ startX: 0.27, startY: 0.50, endX: 0.51, endY: 0.30 },
	{ startX: 0.29, startY: 0.852, endX: 0.51, endY: 0.30 },
];

function drawRainbowLine(startX, startY, endX, endY) {
	var gradient = ctx.createLinearGradient(canvas.width * startX, canvas.height * startY, canvas.width * endX, canvas.height * endY);
	gradient.addColorStop(0, 'rgba(0, 0, 255, 1)');
	
	gradient.addColorStop(1, 'rgba(0, 0, 255, 1)');

	var lineWidthPercentage = 0.4; // 선의 두께를 캔버스 너비의 %로 설정
	ctx.lineWidth = (canvas.width * lineWidthPercentage) / 100; // 상대적인 비율을 픽셀 단위로 계산하여 선의 두께로 설정
	ctx.strokeStyle = gradient;


	function drawLineAnimated() {
		var progress = 0;
		var interval = setInterval(function() {
			if (progress >= 100) {
				clearInterval(interval);
			} else {
				ctx.clearRect(0, 0, canvas.width, canvas.height);
				var currentX = canvas.width * (startX + (endX - startX) * (progress / 100));
				var currentY = canvas.height * (startY + (endY - startY) * (progress / 100));

				ctx.beginPath();
				ctx.moveTo(canvas.width * startX, canvas.height * startY);
				ctx.lineTo(currentX, currentY);
				ctx.stroke();

				progress += 1;
			}
		}, 5); // 숫자로 애니메이션의 시간 조정
	}

	drawLineAnimated();
}



// 각 div를 클릭했을 때 해당 선을 그리는 반복문  // 선연결은 일단은 안쓰기로 함
/*
for (var i = 0; i < lines.length; i++) {
	var light = document.getElementById('light' + (i + 1));
	var line = lines[i];
	var light_div = document.getElementById('light_div' + (i + 1));

	light.addEventListener('click', function(line) {
		return function() {


			drawRainbowLine(line.startX, line.startY, line.endX, line.endY);

		}

	}(line));


}
*/
/*각 이미지별 번호에 해당하는 div를 제외하고는 나머지는 hidden 클래스 부여*/

light1.addEventListener('click', function() {
	light_div1.classList.remove('hidden');
	light_div2.classList.add('hidden');
	light_div3.classList.add('hidden');
	light_div4.classList.add('hidden');
	light_div5.classList.add('hidden');
	light_div6.classList.add('hidden');
	light_div7.classList.add('hidden');
	light_div8.classList.add('hidden');
	light_div1.classList.add('animated');
	
	light1.classList.remove('parts_light');
	light1.classList.remove('a');
	light1.classList.add('parts_light_color');
	
	light2.classList.add('parts_light');
	light2.classList.add('a');
	light2.classList.remove('parts_light_color');
	
	light3.classList.add('parts_light');
	light3.classList.add('a');
	light3.classList.remove('parts_light_color');
	
	light4.classList.add('parts_light');
	light4.classList.add('a');
	light4.classList.remove('parts_light_color');
	
	light5.classList.add('parts_light');
	light5.classList.add('a');
	light5.classList.remove('parts_light_color');
	
	light6.classList.add('parts_light');
	light6.classList.add('a');
	light6.classList.remove('parts_light_color');
	
	light7.classList.add('parts_light');
	light7.classList.add('a');
	light7.classList.remove('parts_light_color');
	
	light8.classList.add('parts_light');
	light8.classList.add('a');
	light8.classList.remove('parts_light_color');

});

light2.addEventListener('click', function() {
	light_div1.classList.add('hidden');
	light_div2.classList.remove('hidden');
	light_div3.classList.add('hidden');
	light_div4.classList.add('hidden');
	light_div5.classList.add('hidden');
	light_div6.classList.add('hidden');
	light_div7.classList.add('hidden');
	light_div8.classList.add('hidden');
	light_div2.classList.add('animated');
	
	light1.classList.add('parts_light');
	light1.classList.add('a');
	light1.classList.remove('parts_light_color');
	
	light2.classList.remove('parts_light');
	light2.classList.remove('a');
	light2.classList.add('parts_light_color');
	
	light3.classList.add('parts_light');
	light3.classList.add('a');
	light3.classList.remove('parts_light_color');
	
	light4.classList.add('parts_light');
	light4.classList.add('a');
	light4.classList.remove('parts_light_color');
	
	light5.classList.add('parts_light');
	light5.classList.add('a');
	light5.classList.remove('parts_light_color');
	
	light6.classList.add('parts_light');
	light6.classList.add('a');
	light6.classList.remove('parts_light_color');
	
	light7.classList.add('parts_light');
	light7.classList.add('a');
	light7.classList.remove('parts_light_color');
	
	light8.classList.add('parts_light');
	light8.classList.add('a');
	light8.classList.remove('parts_light_color');
});

light3.addEventListener('click', function() {
	light_div1.classList.add('hidden');
	light_div2.classList.add('hidden');
	light_div3.classList.remove('hidden');
	light_div4.classList.add('hidden');
	light_div5.classList.add('hidden');
	light_div6.classList.add('hidden');
	light_div7.classList.add('hidden');
	light_div8.classList.add('hidden');
	light_div3.classList.add('animated');
	
	light1.classList.add('parts_light');
	light1.classList.add('a');
	light1.classList.remove('parts_light_color');
	
	light2.classList.add('parts_light');
	light2.classList.add('a');
	light2.classList.remove('parts_light_color');
	
	light3.classList.remove('parts_light');
	light3.classList.remove('a');
	light3.classList.add('parts_light_color');
	
	light4.classList.add('parts_light');
	light4.classList.add('a');
	light4.classList.remove('parts_light_color');
	
	light5.classList.add('parts_light');
	light5.classList.add('a');
	light5.classList.remove('parts_light_color');
	
	light6.classList.add('parts_light');
	light6.classList.add('a');
	light6.classList.remove('parts_light_color');
	
	light7.classList.add('parts_light');
	light7.classList.add('a');
	light7.classList.remove('parts_light_color');
	
	light8.classList.add('parts_light');
	light8.classList.add('a');
	light8.classList.remove('parts_light_color');
});

light4.addEventListener('click', function() {
	light_div1.classList.add('hidden');
	light_div2.classList.add('hidden');
	light_div3.classList.add('hidden');
	light_div4.classList.remove('hidden');
	light_div5.classList.add('hidden');
	light_div6.classList.add('hidden');
	light_div7.classList.add('hidden');
	light_div8.classList.add('hidden');
	light_div4.classList.add('animated');
	
	light1.classList.add('parts_light');
	light1.classList.add('a');
	light1.classList.remove('parts_light_color');
	
	light2.classList.add('parts_light');
	light2.classList.add('a');
	light2.classList.remove('parts_light_color');
	
	light3.classList.add('parts_light');
	light3.classList.add('a');
	light3.classList.remove('parts_light_color');
	
	light4.classList.remove('parts_light');
	light4.classList.remove('a');
	light4.classList.add('parts_light_color');
	
	light5.classList.add('parts_light');
	light5.classList.add('a');
	light5.classList.remove('parts_light_color');
	
	light6.classList.add('parts_light');
	light6.classList.add('a');
	light6.classList.remove('parts_light_color');
	
	light7.classList.add('parts_light');
	light7.classList.add('a');
	light7.classList.remove('parts_light_color');
	
	light8.classList.add('parts_light');
	light8.classList.add('a');
	light8.classList.remove('parts_light_color');
});

light5.addEventListener('click', function() {
	light_div1.classList.add('hidden');
	light_div2.classList.add('hidden');
	light_div3.classList.add('hidden');
	light_div4.classList.add('hidden');
	light_div5.classList.remove('hidden');
	light_div6.classList.add('hidden');
	light_div7.classList.add('hidden');
	light_div8.classList.add('hidden');
	light_div5.classList.add('animated');
	
	light1.classList.add('parts_light');
	light1.classList.add('a');
	light1.classList.remove('parts_light_color');
	
	light2.classList.add('parts_light');
	light2.classList.add('a');
	light2.classList.remove('parts_light_color');
	
	light3.classList.add('parts_light');
	light3.classList.add('a');
	light3.classList.remove('parts_light_color');
	
	light4.classList.add('parts_light');
	light4.classList.add('a');
	light4.classList.remove('parts_light_color');
	
	light5.classList.remove('parts_light');
	light5.classList.remove('a');
	light5.classList.add('parts_light_color');
	
	light6.classList.add('parts_light');
	light6.classList.add('a');
	light6.classList.remove('parts_light_color');
	
	light7.classList.add('parts_light');
	light7.classList.add('a');
	light7.classList.remove('parts_light_color');
	
	light8.classList.add('parts_light');
	light8.classList.add('a');
	light8.classList.remove('parts_light_color');
});

light6.addEventListener('click', function() {
	light_div1.classList.add('hidden');
	light_div2.classList.add('hidden');
	light_div3.classList.add('hidden');
	light_div4.classList.add('hidden');
	light_div5.classList.add('hidden');
	light_div6.classList.remove('hidden');
	light_div7.classList.add('hidden');
	light_div8.classList.add('hidden');
	light_div6.classList.add('animated');
	
	light1.classList.add('parts_light');
	light1.classList.add('a');
	light1.classList.remove('parts_light_color');
	
	light2.classList.add('parts_light');
	light2.classList.add('a');
	light2.classList.remove('parts_light_color');
	
	light3.classList.add('parts_light');
	light3.classList.add('a');
	light3.classList.remove('parts_light_color');
	
	light4.classList.add('parts_light');
	light4.classList.add('a');
	light4.classList.remove('parts_light_color');
	
	light5.classList.add('parts_light');
	light5.classList.add('a');
	light5.classList.remove('parts_light_color');
	
	light6.classList.remove('parts_light');
	light6.classList.remove('a');
	light6.classList.add('parts_light_color');
	
	light7.classList.add('parts_light');
	light7.classList.add('a');
	light7.classList.remove('parts_light_color');
	
	light8.classList.add('parts_light');
	light8.classList.add('a');
	light8.classList.remove('parts_light_color');
});

light7.addEventListener('click', function() {
	light_div1.classList.add('hidden');
	light_div2.classList.add('hidden');
	light_div3.classList.add('hidden');
	light_div4.classList.add('hidden');
	light_div5.classList.add('hidden');
	light_div6.classList.add('hidden');
	light_div7.classList.remove('hidden');
	light_div8.classList.add('hidden');
	light_div7.classList.add('animated');
	
	light1.classList.add('parts_light');
	light1.classList.add('a');
	light1.classList.remove('parts_light_color');
	
	light2.classList.add('parts_light');
	light2.classList.add('a');
	light2.classList.remove('parts_light_color');
	
	light3.classList.add('parts_light');
	light3.classList.add('a');
	light3.classList.remove('parts_light_color');
	
	light4.classList.add('parts_light');
	light4.classList.add('a');
	light4.classList.remove('parts_light_color');
	
	light5.classList.add('parts_light');
	light5.classList.add('a');
	light5.classList.remove('parts_light_color');
	
	light6.classList.add('parts_light');
	light6.classList.add('a');
	light6.classList.remove('parts_light_color');
	
	light7.classList.remove('parts_light');
	light7.classList.remove('a');
	light7.classList.add('parts_light_color');
	
	light8.classList.add('parts_light');
	light8.classList.add('a');
	light8.classList.remove('parts_light_color');
});

light8.addEventListener('click', function() {
	light_div1.classList.add('hidden');
	light_div2.classList.add('hidden');
	light_div3.classList.add('hidden');
	light_div4.classList.add('hidden');
	light_div5.classList.add('hidden');
	light_div6.classList.add('hidden');
	light_div7.classList.add('hidden');
	light_div8.classList.remove('hidden');
	light_div8.classList.add('animated');
	
	light1.classList.add('parts_light');
	light1.classList.add('a');
	light1.classList.remove('parts_light_color');
	
	light2.classList.add('parts_light');
	light2.classList.add('a');
	light2.classList.remove('parts_light_color');
	
	light3.classList.add('parts_light');
	light3.classList.add('a');
	light3.classList.remove('parts_light_color');
	
	light4.classList.add('parts_light');
	light4.classList.add('a');
	light4.classList.remove('parts_light_color');
	
	light5.classList.add('parts_light');
	light5.classList.add('a');
	light5.classList.remove('parts_light_color');
	
	light6.classList.add('parts_light');
	light6.classList.add('a');
	light6.classList.remove('parts_light_color');
	
	light7.classList.add('parts_light');
	light7.classList.add('a');
	light7.classList.remove('parts_light_color');
	
	light8.classList.remove('parts_light');
	light8.classList.remove('a');
	light8.classList.add('parts_light_color');
});



/*for (var i = 0; i < lines.length; i++) {
	var divId = 'light' + (i + 1);
	var div = document.getElementById(divId);
	div.addEventListener('click', function() {
		var lineIndex = parseInt(this.id.replace('light', '')) - 1;
		var line = lines[lineIndex];
		drawRainbowLine(line.startX, line.startY, line.endX, line.endY);
	});
}*/




/* 머리부분 빨간색 원의 위치를 조정하는 함수*/
function adjustHeadLightPosition() {
	var humanModel = document.getElementById('human_model');
	var headLight = document.getElementById('light1');

	headLight.style.position = 'absolute';
	humanModel.style.position = 'relative'; // human_model도 relative로 설정

	headLight.style.width = (humanModel.offsetWidth * 0.04) + 'px';
	headLight.style.height = (humanModel.offsetWidth * 0.04) + 'px';


	headLight.style.top = '5.3%'; // 원하는 위치로 조절
	headLight.style.left = '24.1%'; // 원하는 위치로 조절

}

/* 머리부분 div의 위치를 조정하는 함수*/
function adjustHeadLightPositionDiv() {
	var humanModel = document.getElementById('human_model');
	var headLightDiv = document.getElementById('light_div1');

	headLightDiv.style.position = 'absolute';
	humanModel.style.position = 'relative'; // human_model도 relative로 설정

	headLightDiv.style.top = '10%'; // 원하는 위치로 조절
	headLightDiv.style.left = '50%'; // 원하는 위치로 조절
}

/* 머리부분 container의 크기에 따라 글자 크기 조정*/
function adjustFontSize1() {
	var containerWidth = document.querySelector('.container').offsetWidth;
	var fontSize = containerWidth * 0.02; // 원하는 비율로 조절 (2%)
	document.querySelector('#light_div1').style.fontSize = fontSize + 'px';
}

document.addEventListener('DOMContentLoaded', adjustFontSize1);
window.addEventListener('resize', adjustFontSize1);




/*장장장장장장장장장장장장장장장장장장장장장장장장장장장장장장장장장장장장장장장장장장장장*/
/* 장부분 빨간색 원의 위치를 조정하는 함수*/
function adjustHeadLightPosition2() {
	var humanModel = document.getElementById('human_model');
	var headLight = document.getElementById('light2');

	headLight.style.position = 'absolute';
	humanModel.style.position = 'relative'; // human_model도 relative로 설정

	headLight.style.width = (humanModel.offsetWidth * 0.04) + 'px';
	headLight.style.height = (humanModel.offsetWidth * 0.04) + 'px';

	headLight.style.top = '39%'; // 원하는 위치로 조절
	headLight.style.left = '24.7%'; // 원하는 위치로 조절

}

/* 장부분 div의 위치를 조정하는 함수*/
function adjustHeadLightPositionDiv2() {
	var humanModel = document.getElementById('human_model');
	var headLightDiv = document.getElementById('light_div2');

	headLightDiv.style.position = 'absolute';
	humanModel.style.position = 'relative'; // human_model도 relative로 설정

	headLightDiv.style.top = '10%'; // 원하는 위치로 조절
	headLightDiv.style.left = '50%'; // 원하는 위치로 조절
}

/* 장부분 container의 크기에 따라 글자 크기 조정*/
function adjustFontSize2() {
	var containerWidth = document.querySelector('.container').offsetWidth;
	var fontSize = containerWidth * 0.02; // 원하는 비율로 조절 (2%)
	document.querySelector('#light_div2').style.fontSize = fontSize + 'px';
}

document.addEventListener('DOMContentLoaded', adjustFontSize2);
window.addEventListener('resize', adjustFontSize2);


/*팔꿈치팔꿈치팔꿈치팔꿈치팔꿈치팔꿈치팔꿈치팔꿈치팔꿈치팔꿈치팔꿈치팔꿈치*/
/* 팔꿈치부분 빨간색 원의 위치를 조정하는 함수*/
function adjustHeadLightPosition3() {
	var humanModel = document.getElementById('human_model');
	var headLight = document.getElementById('light3');

	headLight.style.position = 'absolute';
	humanModel.style.position = 'relative'; // human_model도 relative로 설정

	headLight.style.width = (humanModel.offsetWidth * 0.025) + 'px';
	headLight.style.height = (humanModel.offsetWidth * 0.025) + 'px';

	headLight.style.top = '38.7%'; // 원하는 위치로 조절
	headLight.style.left = '18.2%'; // 원하는 위치로 조절

}

/* 팔꿈치부분 div의 위치를 조정하는 함수*/
function adjustHeadLightPositionDiv3() {
	var humanModel = document.getElementById('human_model');
	var headLightDiv = document.getElementById('light_div3');

	headLightDiv.style.position = 'absolute';
	humanModel.style.position = 'relative'; // human_model도 relative로 설정

	headLightDiv.style.top = '10%'; // 원하는 위치로 조절
	headLightDiv.style.left = '50%'; // 원하는 위치로 조절
}

/* 팔꿈치부분 container의 크기에 따라 글자 크기 조정*/
function adjustFontSize3() {
	var containerWidth = document.querySelector('.container').offsetWidth;
	var fontSize = containerWidth * 0.02; // 원하는 비율로 조절 (2%)
	document.querySelector('#light_div3').style.fontSize = fontSize + 'px';
}

document.addEventListener('DOMContentLoaded', adjustFontSize3);
window.addEventListener('resize', adjustFontSize3);


/*무릎무릎무릎무릎무릎무릎무릎무릎무릎무릎무릎무릎무릎무릎무릎무릎무릎*/
/* 무릎부분 빨간색 원의 위치를 조정하는 함수*/
function adjustHeadLightPosition4() {
	var humanModel = document.getElementById('human_model');
	var headLight = document.getElementById('light4');

	headLight.style.position = 'absolute';
	humanModel.style.position = 'relative'; // human_model도 relative로 설정

	headLight.style.width = (humanModel.offsetWidth * 0.025) + 'px';
	headLight.style.height = (humanModel.offsetWidth * 0.025) + 'px';

	headLight.style.top = '70.3%'; // 원하는 위치로 조절
	headLight.style.left = '21.7%'; // 원하는 위치로 조절

}

/* 무릎부분 div의 위치를 조정하는 함수*/
function adjustHeadLightPositionDiv4() {
	var humanModel = document.getElementById('human_model');
	var headLightDiv = document.getElementById('light_div4');

	headLightDiv.style.position = 'absolute';
	humanModel.style.position = 'relative'; // human_model도 relative로 설정

	headLightDiv.style.top = '10%'; // 원하는 위치로 조절
	headLightDiv.style.left = '50%'; // 원하는 위치로 조절
}

/* 무릎부분 container의 크기에 따라 글자 크기 조정*/
function adjustFontSize4() {
	var containerWidth = document.querySelector('.container').offsetWidth;
	var fontSize = containerWidth * 0.02; // 원하는 비율로 조절 (2%)
	document.querySelector('#light_div4').style.fontSize = fontSize + 'px';
}

document.addEventListener('DOMContentLoaded', adjustFontSize4);
window.addEventListener('resize', adjustFontSize4);


/* 목목목목목목목목목목목목목목목목목목목목목목목목목목목목목목목목목목목목목목목목목목*/
/* 목부분 빨간색 원의 위치를 조정하는 함수*/
function adjustHeadLightPosition5() {
	var humanModel = document.getElementById('human_model');
	var headLight = document.getElementById('light5');

	headLight.style.position = 'absolute';
	humanModel.style.position = 'relative'; // human_model도 relative로 설정

	headLight.style.width = (humanModel.offsetWidth * 0.025) + 'px';
	headLight.style.height = (humanModel.offsetWidth * 0.025) + 'px';

	headLight.style.top = '14.7%'; // 원하는 위치로 조절
	headLight.style.left = '24.9%'; // 원하는 위치로 조절

}

/* 목부분 div의 위치를 조정하는 함수*/
function adjustHeadLightPositionDiv5() {
	var humanModel = document.getElementById('human_model');
	var headLightDiv = document.getElementById('light_div5');

	headLightDiv.style.position = 'absolute';
	humanModel.style.position = 'relative'; // human_model도 relative로 설정

	headLightDiv.style.top = '10%'; // 원하는 위치로 조절
	headLightDiv.style.left = '50%'; // 원하는 위치로 조절
}

/* 목부분 container의 크기에 따라 글자 크기 조정*/
function adjustFontSize5() {
	var containerWidth = document.querySelector('.container').offsetWidth;
	var fontSize = containerWidth * 0.02; // 원하는 비율로 조절 (2%)
	document.querySelector('#light_div5').style.fontSize = fontSize + 'px';
}

document.addEventListener('DOMContentLoaded', adjustFontSize5);
window.addEventListener('resize', adjustFontSize5);


/* 위위위위위위위위위위위위위위위위위위위위위위위위위위위위위위위위위위위위위위위위위*/
/* 위부분 빨간색 원의 위치를 조정하는 함수*/
function adjustHeadLightPosition6() {
	var humanModel = document.getElementById('human_model');
	var headLight = document.getElementById('light6');

	headLight.style.position = 'absolute';
	humanModel.style.position = 'relative'; // human_model도 relative로 설정

	headLight.style.width = (humanModel.offsetWidth * 0.04) + 'px';
	headLight.style.height = (humanModel.offsetWidth * 0.04) + 'px';

	headLight.style.top = '28.7%'; // 원하는 위치로 조절
	headLight.style.left = '26.4%'; // 원하는 위치로 조절

}

/* 위부분 div의 위치를 조정하는 함수*/
function adjustHeadLightPositionDiv6() {
	var humanModel = document.getElementById('human_model');
	var headLightDiv = document.getElementById('light_div6');

	headLightDiv.style.position = 'absolute';
	humanModel.style.position = 'relative'; // human_model도 relative로 설정

	headLightDiv.style.top = '10%'; // 원하는 위치로 조절
	headLightDiv.style.left = '50%'; // 원하는 위치로 조절
}

/* 위부분 container의 크기에 따라 글자 크기 조정*/
function adjustFontSize6() {
	var containerWidth = document.querySelector('.container').offsetWidth;
	var fontSize = containerWidth * 0.02; // 원하는 비율로 조절 (2%)
	document.querySelector('#light_div6').style.fontSize = fontSize + 'px';
}

document.addEventListener('DOMContentLoaded', adjustFontSize6);
window.addEventListener('resize', adjustFontSize6);


/* 전립선전립선전립선전립선전립선전립선전립선전립선전립선전립선전립선전립선*/
/* 전립선부분 빨간색 원의 위치를 조정하는 함수*/
function adjustHeadLightPosition7() {
	var humanModel = document.getElementById('human_model');
	var headLight = document.getElementById('light7');

	headLight.style.position = 'absolute';
	humanModel.style.position = 'relative'; // human_model도 relative로 설정

	headLight.style.width = (humanModel.offsetWidth * 0.04) + 'px';
	headLight.style.height = (humanModel.offsetWidth * 0.04) + 'px';

	headLight.style.top = '47.8%'; // 원하는 위치로 조절
	headLight.style.left = '24.7%'; // 원하는 위치로 조절

}

/* 전립선부분 div의 위치를 조정하는 함수*/
function adjustHeadLightPositionDiv7() {
	var humanModel = document.getElementById('human_model');
	var headLightDiv = document.getElementById('light_div7');

	headLightDiv.style.position = 'absolute';
	humanModel.style.position = 'relative'; // human_model도 relative로 설정

	headLightDiv.style.top = '10%'; // 원하는 위치로 조절
	headLightDiv.style.left = '50%'; // 원하는 위치로 조절
}

/* 전립선부분 container의 크기에 따라 글자 크기 조정*/
function adjustFontSize7() {
	var containerWidth = document.querySelector('.container').offsetWidth;
	var fontSize = containerWidth * 0.02; // 원하는 비율로 조절 (2%)
	document.querySelector('#light_div7').style.fontSize = fontSize + 'px';
}

document.addEventListener('DOMContentLoaded', adjustFontSize7);
window.addEventListener('resize', adjustFontSize7);

/* 발목발목발목발목발목발목발목발목발목발목발목발목발목*/
/* 발목부분 빨간색 원의 위치를 조정하는 함수*/
function adjustHeadLightPosition8() {
	var humanModel = document.getElementById('human_model');
	var headLight = document.getElementById('light8');

	headLight.style.position = 'absolute';
	humanModel.style.position = 'relative'; // human_model도 relative로 설정

	headLight.style.width = (humanModel.offsetWidth * 0.02) + 'px';
	headLight.style.height = (humanModel.offsetWidth * 0.02) + 'px';

	headLight.style.top = '84.3%'; // 원하는 위치로 조절
	headLight.style.left = '27.4%'; // 원하는 위치로 조절

}

/* 발목부분 div의 위치를 조정하는 함수*/
function adjustHeadLightPositionDiv8() {
	var humanModel = document.getElementById('human_model');
	var headLightDiv = document.getElementById('light_div8');

	headLightDiv.style.position = 'absolute';
	humanModel.style.position = 'relative'; // human_model도 relative로 설정

	headLightDiv.style.top = '10%'; // 원하는 위치로 조절
	headLightDiv.style.left = '50%'; // 원하는 위치로 조절
}

/* 발목부분 container의 크기에 따라 글자 크기 조정*/
function adjustFontSize8() {
	var containerWidth = document.querySelector('.container').offsetWidth;
	var fontSize = containerWidth * 0.02; // 원하는 비율로 조절 (2%)
	document.querySelector('#light_div8').style.fontSize = fontSize + 'px';
}

document.addEventListener('DOMContentLoaded', adjustFontSize8);
window.addEventListener('resize', adjustFontSize8);


/* f5 여러번 눌렀을때 위치 안변하도록*/
/*1*/
document.removeEventListener('DOMContentLoaded', adjustHeadLightPosition);
window.addEventListener('resize', adjustHeadLightPosition);
document.addEventListener('DOMContentLoaded', adjustHeadLightPosition);

document.removeEventListener('DOMContentLoaded', adjustHeadLightPositionDiv);
window.addEventListener('resize', adjustHeadLightPositionDiv);
document.addEventListener('DOMContentLoaded', adjustHeadLightPositionDiv);

/*2*/
document.removeEventListener('DOMContentLoaded', adjustHeadLightPosition2);
window.addEventListener('resize', adjustHeadLightPosition2);
document.addEventListener('DOMContentLoaded', adjustHeadLightPosition2);

document.removeEventListener('DOMContentLoaded', adjustHeadLightPositionDiv2);
window.addEventListener('resize', adjustHeadLightPositionDiv2);
document.addEventListener('DOMContentLoaded', adjustHeadLightPositionDiv2);

/*3*/
document.removeEventListener('DOMContentLoaded', adjustHeadLightPosition3);
window.addEventListener('resize', adjustHeadLightPosition3);
document.addEventListener('DOMContentLoaded', adjustHeadLightPosition3);

document.removeEventListener('DOMContentLoaded', adjustHeadLightPositionDiv3);
window.addEventListener('resize', adjustHeadLightPositionDiv3);
document.addEventListener('DOMContentLoaded', adjustHeadLightPositionDiv3);

/*4*/
document.removeEventListener('DOMContentLoaded', adjustHeadLightPosition4);
window.addEventListener('resize', adjustHeadLightPosition4);
document.addEventListener('DOMContentLoaded', adjustHeadLightPosition4);

document.removeEventListener('DOMContentLoaded', adjustHeadLightPositionDiv4);
window.addEventListener('resize', adjustHeadLightPositionDiv4);
document.addEventListener('DOMContentLoaded', adjustHeadLightPositionDiv4);

/*5*/
document.removeEventListener('DOMContentLoaded', adjustHeadLightPosition5);
window.addEventListener('resize', adjustHeadLightPosition5);
document.addEventListener('DOMContentLoaded', adjustHeadLightPosition5);

document.removeEventListener('DOMContentLoaded', adjustHeadLightPositionDiv5);
window.addEventListener('resize', adjustHeadLightPositionDiv5);
document.addEventListener('DOMContentLoaded', adjustHeadLightPositionDiv5);

/*6*/
document.removeEventListener('DOMContentLoaded', adjustHeadLightPosition6);
window.addEventListener('resize', adjustHeadLightPosition6);
document.addEventListener('DOMContentLoaded', adjustHeadLightPosition6);

document.removeEventListener('DOMContentLoaded', adjustHeadLightPositionDiv6);
window.addEventListener('resize', adjustHeadLightPositionDiv6);
document.addEventListener('DOMContentLoaded', adjustHeadLightPositionDiv6);

/*7*/
document.removeEventListener('DOMContentLoaded', adjustHeadLightPosition7);
window.addEventListener('resize', adjustHeadLightPosition7);
document.addEventListener('DOMContentLoaded', adjustHeadLightPosition7);

document.removeEventListener('DOMContentLoaded', adjustHeadLightPositionDiv7);
window.addEventListener('resize', adjustHeadLightPositionDiv7);
document.addEventListener('DOMContentLoaded', adjustHeadLightPositionDiv7);

/*8*/
document.removeEventListener('DOMContentLoaded', adjustHeadLightPosition8);
window.addEventListener('resize', adjustHeadLightPosition8);
document.addEventListener('DOMContentLoaded', adjustHeadLightPosition8);

document.removeEventListener('DOMContentLoaded', adjustHeadLightPositionDiv8);
window.addEventListener('resize', adjustHeadLightPositionDiv8);
document.addEventListener('DOMContentLoaded', adjustHeadLightPositionDiv8);







/* 마우스 클릭효과*/
// 클릭 이벤트 핸들러를 정의
function clickEffect(e) {
	var d = document.createElement("div");
	d.className = "clickEffect";
	d.style.top = e.clientY + "px";
	d.style.left = e.clientX + "px";
	document.body.appendChild(d);
	d.addEventListener('animationend', function() {
		d.parentElement.removeChild(d);
	});
}

// 클릭 이벤트 핸들러를 문서에서 제거
document.removeEventListener('click', clickEffect);

// 기존 div 태그에 클릭 이펙트를 추가
var divElements = document.querySelectorAll('div'); // 여기에서 'div'는 기존 div 태그를 선택하는 선택자
for (var i = 0; i < divElements.length; i++) {
	divElements[i].addEventListener('click', function(e) {
		clickEffect(e);
	});
}

// 문서 전체에서 클릭 이벤트를 처리하지 않도록 이벤트 전파를 막기 위한 코드
document.addEventListener('click', function(e) {
	e.stopPropagation();
});