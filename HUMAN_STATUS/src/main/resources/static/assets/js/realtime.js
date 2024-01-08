function updateData1() {
    $.ajax({
        url: "bigdata/vcon1", // 백엔드 엔드포인트 URL
        type: "GET",
        dataType: "json",
        success: function(data) {
            console.log("서버 응답:", data); // 서버 응답 로그 출력

            // 기존 데이터와 새 데이터가 다른 경우에만 업데이트
            var currentData = $("#numsber").text();
            if (currentData !== data.toString()) {
                $("#numsber").empty();
                var regionElement = $('<div class="region-data"></div>');
                var numberDisplay = $('<p class="numberDisplay animate__animated animate__flipInY">' + 0 +data + '</p>');
                regionElement.append(numberDisplay);

                if (data >= 2) {
                    var warningMessage = $('<p class="warning-message" style="color: red;"> 경고! <br>절반이상의 아이들이 조는중. </p>');
                    regionElement.append(warningMessage);
                }

                $("#numsber").append(regionElement);
            }
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 오류:", error); // 오류 로그 출력
        }
    });
}

$(document).ready(function() {
    updateData1(); // 최초 실행
    setInterval(updateData1, 2000); // 2초마다 반복 실행
});