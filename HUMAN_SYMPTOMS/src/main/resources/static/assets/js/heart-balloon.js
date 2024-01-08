document.addEventListener("DOMContentLoaded", function () {
    const balloon_container = document.querySelector('body');

    function createHeartBalloon() {
        const heartBalloon = document.createElement("div");
        heartBalloon.classList.add("heart-balloon");
        heartBalloon.style.left = `${Math.random() * window.innerWidth}px`;
        balloon_container.appendChild(heartBalloon);
        setTimeout(() => {
            balloon_container.removeChild(heartBalloon);
        }, 5000); // 5초 후에 풍선을 삭제
    }

    // 일정 간격으로 하트 풍선을 생성
    setInterval(createHeartBalloon, 500); // 0.5초마다 하트 풍선 생성
});