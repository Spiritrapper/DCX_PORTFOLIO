"use strict";
jQuery(document).ready(function ($) {

//for Preloader

    $(window).load(function () {
        $("#loading").fadeOut(500);
    });


    /*---------------------------------------------*
     * Mobile menu
     ---------------------------------------------*/
    $('#navbar-menu').find('a[href*=#]:not([href=#])').click(function () {
        if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
            if (target.length) {
                $('html,body').animate({
                    scrollTop: (target.offset().top - 80)
                }, 1000);
                if ($('.navbar-toggle').css('display') != 'none') {
                    $(this).parents('.container').find(".navbar-toggle").trigger("click");
                }
                return false;
            }
        }
    });



    /*---------------------------------------------*
     * WOW
     ---------------------------------------------*/

    var wow = new WOW({
        mobile: false // trigger animations on mobile devices (default is true)
    });
    wow.init();

// magnificPopup

    $('.popup-img').magnificPopup({
        type: 'image',
        gallery: {
            enabled: true
        }
    });

    $('.video-link').magnificPopup({
        type: 'iframe'
    });



// slick slider active Home Page Tow
    $(".hello_slid").slick({
        dots: true,
        infinite: false,
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: true,
        prevArrow: "<i class='icon icon-chevron-left nextprevleft'></i>",
        nextArrow: "<i class='icon icon-chevron-right nextprevright'></i>",
        autoplay: true,
        autoplaySpeed: 20000
    });
    
    
    
    $(".business_items").slick({
        dots: true,
        infinite: false,
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: true,
        prevArrow: "<i class='icon icon-chevron-left nextprevleft'></i>",
        nextArrow: "<i class='icon icon-chevron-right nextprevright'></i>",
        autoplay: true,
        autoplaySpeed: 20000
    });




//---------------------------------------------
// Scroll Up 
//---------------------------------------------

    $('.scrollup').click(function () {
        $("html, body").animate({scrollTop: 0}, 1000);
        return false;
    });











    //End

});



var join_1 = document.querySelector('.join_1');

var login_right2 = document.getElementById('login_right2');
var joinForm = document.getElementById('joinForm');


join_1.addEventListener('click', function() {
   
   login_right2.classList.add('hidden');
   joinForm.classList.remove('hidden');
});

/*로그인 물결*/
$(document).ready(function () {
   $(".overlay").ripples({
      resolution: 256,
      perturbance: 0.02, // Replace the semicolon with a comma here
   });
});

/*로그인 캐릭터*/
      // 페이지 로드 후 1초 뒤에 버블을 만들고 애니메이션을 시작합니다.
document.addEventListener('DOMContentLoaded', function () {
            setTimeout(createBubbles, 3000);
        });

        function createBubbles() {
            const Zzz = document.querySelector('.Zzz');

            for (let i = 0; i < 2; i++) {
                const bubble = document.createElement('div');
                bubble.className = 'bubble';

                // 각 위치를 조정하여 여러 버블이 서로 약간 겹치게 표시됩니다.
                bubble.style.top = `${i * 25}px`;
                
                // 두 번째 버블을 첫 번째 버블의 왼쪽으로 5px 이동합니다.
                if (i === 1) {
                    bubble.style.left = '-5px';
                }

                Zzz.appendChild(풍선껌);
            }
        }

/* 메인 버블*/
document.addEventListener('DOMContentLoaded', function () {
    // 버블 생성 함수 호출
    createBubbles();
});

function createBubbles() {
    // 버블이 담길 컨테이너 요소 가져오기
    const bubbleContainer = document.getElementById('bubble-container');
    // 생성할 버블 개수
    const numBubbles = 20;

    for (let i = 0; i < numBubbles; i++) {
        // 새로운 div 요소 생성 (버블 역할)
        const bubble = document.createElement('div');
        // 버블의 클래스 지정
        bubble.className = 'bubble';

        // 버블의 가로 위치를 랜덤으로 설정
        const position = Math.random() * 100;
        bubble.style.left = `${position}%`;

        // 시작 시간을 랜덤으로 조정하여 다양한 타이밍에 애니메이션 시작
        const delay = Math.random() * 8;
        bubble.style.animationDelay = `-${delay}s`;

        // 버블을 컨테이너에 추가
        bubbleContainer.appendChild(bubble);
    }
}