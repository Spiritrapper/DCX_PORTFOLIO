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