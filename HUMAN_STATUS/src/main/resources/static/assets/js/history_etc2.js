(function(){
    $(function(){
      // calendar element 취득
      var calendarEl = $('#calendar')[0];
      // full-calendar 생성하기
      var calendar = new FullCalendar.Calendar(calendarEl, {
        height: '400px',
         // calendar 높이 설정
        expandRows: false, // 화면에 맞게 높이 재설정
      
        slotMinTime: '08:00', // Day 캘린더에서 시작 시간
        slotMaxTime: '20:00', // Day 캘린더에서 종료 시간
        // 해더에 표시할 툴바
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
        },
        initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
        initialDate: '2023-12-01', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
        navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
        editable: true, // 수정 가능?
        selectable: true, // 달력 일자 드래그 설정가능
        nowIndicator: true, // 현재 시간 마크
        dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
        locale: 'ko', // 한국어 설정
        eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
          console.log(obj);
        },
        eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
          console.log(obj);
        },
        eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
          console.log(obj);
        },
        select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
          var title = prompt('Event Title:');
          if (title) {
            calendar.addEvent({
              title: title,
              start: arg.start,
              end: arg.end,
              allDay: arg.allDay
            })
          }
          calendar.unselect()
        },
        // 이벤트 
        
      });
      // 캘린더 랜더링
      calendar.render();
    });
  })();


// 배경 색상 플러그인

const bgColor = {
        id: 'bgColor',
        beforeDraw: (chart, options) => {
            const { ctx, width, height } = chart;
            ctx.fillStyle = 'white';
            ctx.fillRect(0, 0, width, height);
            ctx.restore();
        }
    };



// Chart.js 구성
    const config = {
        type: 'bar',
        data,
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        },
        plugins: [bgColor]
    };


 // Change: PDF 차트 1부분 생성 함수에 주석 추가
    function generatePDF() {
        // 캔버스 엘리먼트 가져오기
        const canvas = document.getElementById('mixedChart');
        // 캔버스 이미지 데이터 URL 생성
        const canvasImg = canvas.toDataURL('image/jpg', 1.0);
        // jsPDF 인스턴스 생성 (가로 방향)
        const doc = new jsPDF('landscape');
        // PDF에 텍스트 추가
        //doc.setFontSize(20);
        //doc.text(15, 15, '안녕하세요, 나는 형제입니다.');  // 변경: 한글 텍스트 추가
        // PDF에 캔버스 이미지 추가
        doc.addImage(canvasImg, 'JPG', 10, 30, 280, 150);
        // PDF 저장
        doc.save('Chart.pdf');
    }