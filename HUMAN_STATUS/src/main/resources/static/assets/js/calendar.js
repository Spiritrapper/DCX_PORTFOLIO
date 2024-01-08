var calendar = null;
var initialLocaleCode = 'ko';
var localeSelectorEl = document.getElementById('locale-selector');

function formatToLocalDateTimeString(date) {
    return date ? date.toISOString().replace('Z', ''): null;
}

$(document).ready(function () {
    var calendarEl = document.getElementById('calendar');
    calendar = new FullCalendar.Calendar(calendarEl, {
        height: '400px',
        expandRows: false,
        slotMinTime: '08:00',
        slotMaxTime: '20:00',
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
        },
        initialView: 'dayGridMonth',
        initialDate: '2023-12-01',
        navLinks: true,
        editable: true,
        selectable: true,
        nowIndicator: true,
        dayMaxEvents: true,
        locale: 'ko',
        eventAdd: function(obj) {
            console.log(obj);
        },
        eventChange: function(obj) {
            console.log(obj);
        },
        eventRemove: function(obj){
            console.log(obj);
        },
		// 새 이벤트가 추가될 때 호출되는 함수
        eventAdd: function(info) {
            var event = info.event;
            console.log(event);

            // 서버에 저장하기 위한 이벤트 데이터 생성
            var eventData = {
                id: event.id, // 이벤트 ID
                title: event.title, // 이벤트 제목
 				start: event.start ? event.start.toISOString() : null, // 시작 시간 체크
        		end: event.end ? event.end.toISOString() : null // 종료 시간 체크
			};
			  saveEvent(eventData);
		},
        select: function(arg) {
            var title = prompt('일정을 입력해주세요.');
            if (title) {
                var eventData  = {
                    title: title,
                    start: formatToLocalDateTimeString(arg.start),
                    end: formatToLocalDateTimeString(arg.end)
                    // Add other necessary properties like userId if required
                };
                
                saveEvent(eventData);

            }
            calendar.unselect();
        },
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

    calendar.render();
    fetchEvents(); 
});


function fetchEvents() {
    $.ajax({
        url: 'history/calendar1',
        type: 'GET',

        success: function(events) {
            events.forEach(function(event) {
                calendar.addEvent(event);
            });
        },
        error: function(error) {
            console.error('Error fetching events:', error);
        }
    });
}


/*function saveEvent(eventData) {
	console.log('Saving event:', eventData);
	

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
*/


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
