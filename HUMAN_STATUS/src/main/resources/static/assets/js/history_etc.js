var calendar = null;
var initialLocaleCode = 'ko';
var localeSelectorEl = document.getElementById('locale-selector');

function formatToLocalDateTimeString(date) {
    return date ? date.toISOString().split('.')[0] : null; // 밀리초 제거
}

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

        updateEvent(obj) { // 이벤트가 수정되면 발생하는 이벤트
          console.log(obj);
        },
        eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
          console.log(obj);
        },
     // 새 이벤트가 추가될 때 호출되는 함수
       eventAdd: function(obj) {
            var event = obj.event;
            console.log(event);

            // 서버에 저장하기 위한 이벤트 데이터 생성
            var eventData = {
                id: event.id, // 이벤트 ID
                title: event.title, // 이벤트 제목
 				start: event.start ? event.start.toISOString() : null, // 시작 시간 체크
        		end: event.end ? event.end.toISOString() : null // 종료 시간 체크
			};
			  
		},
        select: function(obj) {
            var title = prompt('일정을 입력해주세요.');
            if (title) {
                var eventData  = {
					
                    title: title,
                    start: formatToLocalDateTimeString(obj.start),
                    end: formatToLocalDateTimeString(obj.end)
                    // Add other necessary properties like userId if required
                };
		   calendar.addEvent({
		              title: title,
		              start: obj.start,
		              end: obj.end,
		              allDay: obj.allDay
		            })

				                
                saveEvent(eventData);
          }
          calendar.unselect()
        },
        // 이벤트 
        events:[
      {
         title: '12월 시작',
         start:'2023-12-01',
      },
      {
         title: '12월 행사',
         start:'2023-12-05',
         end:'2023-12-07',
      },
      {
         title: '수업일',
         start:'2023-12-08',
         end:'2023-12-10',
      },
      {
         groupId:999,
         title: 'Repeating Event',
         start:'2023-12-08T16:00:00',
         
      },
      {
         groupId:999,
         title: 'Repeating Event',
         start:'2023-12-08T16:00:00',
         
      },
      {
         
         title: '수업 미팅',
         start:'2023-12-15',
         
      },
      {
         
         title: '수업 미팅',
         start:'2023-12-18',
         end:'2023-12-19',
         
      }, 
		
      ]

      });
	  
      // 캘린더 랜더링
      calendar.render();
	fetchEvents(); 
	  
    });
 
  })();

function getStoredEvents() {
    var storedEvents = sessionStorage.getItem('events');
    if (storedEvents) {
        return JSON.parse(storedEvents);
    }
    return [];
}

function fetchEvents() {
    $.ajax({
        url: 'history/calendar1',
        type: 'GET',

        success: function(events) {
             events.forEach(function(event) {
                // FullCalendar에 이벤트를 추가하기 위한 형식으로 변환
                var calendarEvent = {
                    id: event.id,
                    title: event.title,
                    start: event.start,
                    end: event.end,
                    // 필요한 경우 다른 속성들도 여기에 추가
                };
                calendar.addEvent(calendarEvent);
            });

			sessionStorage.setItem('events', JSON.stringify(events));
        },
        error: function(error) {
            console.error('Error fetching events:', error);
        }
    });
}


function saveEvent(eventData) {
	console.log('Saving event:', eventData);
	
	    // 사용자 ID 추가 (이미 userId가 설정되어 있는지 확인)
    if (!eventData.id) {
		console.log("아이디가 안들어가.")
        eventData.id = userId; // userId가 전역 변수로 설정되어 있다고 가정
    }
	// 사용자 ID 추가
    eventData.id= userId;

	var dataToSend = [eventData];
    $.ajax({
        url: 'history/saveEvent', // POST 요청을 처리하는 백엔드 엔드포인트
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(dataToSend),
        success: function(response) {
			
            console.log('Event saved:', response);
        },
        error: function(error) {
            console.error('Error saving event:', error);
        }
    });
}



function updateEvent(event) {
    $.ajax({
        url: 'history/updateEvent', // PUT 요청을 처리하는 백엔드 엔드포인트
        type: 'PUT',
        contentType: 'application/json',
        data: JSON.stringify(event),
        success: function(response) {
            console.log('Event updated:', response);
        },
        error: function(error) {
            console.error('Error updating event:', error);
        }
    });
}



function deleteEvent(eventId) {
    $.ajax({
        url: 'history/deleteEvent/' + eventId, // DELETE 요청을 처리하는 백엔드 엔드포인트
        type: 'DELETE',

        success: function(response) {
            console.log('Event deleted:', response);
        },
        error: function(error) {
            console.error('Error deleting event:', error);
        }
    });
}

/*/*db연동 캘랜더*/
    /* document.addEventListener('DOMContentLoaded', function () {*/
            /*$(function () {
                var request = $.ajax({
                    url: "calendar-events",
                    method: "GET",
                    dataType: "json"
                });
 
                request.done(function (data) {
                    console.log(data); // log 로 데이터 찍어주기.
 
                    var calendarEl = document.getElementById('calendar');
 
                    var calendar = new FullCalendar.Calendar(calendarEl, {
                        initialDate: '2023-12-22',
                        initialView: 'timeGridWeek',
                        headerToolbar: {
                            left: 'prev,next today',
                            center: 'title',
                            right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
                        },
                        editable: true,
                        droppable: true, // this allows things to be dropped onto the calendar
                        drop: function (arg) {
                            // is the "remove after drop" checkbox checked?
                            if (document.getElementById('drop-remove').checked) {
                                // if so, remove the element from the "Draggable Events" list
                                arg.draggedEl.parentNode.removeChild(arg.draggedEl);
                            }
                        },
                        /**
                         * data 로 값이 넘어온다. log 값 전달.
                         */
     /*                   events: data
                    });
 
                    calendar.render();
                });
 
                request.fail(function( jqXHR, textStatus ) {
                    alert( "Request failed: " + textStatus );
                });
            });
 
        });*/


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
                 yAxes: [{
	                       ticks: {
	                           beginAtZero: true,
	                           min: 0.0, // Y축 최소값
	                           max: 4.0, // Y축 최대값
	                           stepSize: 1.0 // 눈금 간격
	                       }
	                   }]
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