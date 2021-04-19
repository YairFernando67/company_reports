// document.addEventListener('DOMContentLoaded', function() {
//   var today = new Date();
//   var dd = String(today.getDate()).padStart(2, '0');
//   var mm = String(today.getMonth() + 1).padStart(2, '0');
//   var yyyy = today.getFullYear();
//   var tomorrow = new Date(today);
//   tomorrow.setDate(today.getDate() + 1);
//   var t_dd = String(tomorrow.getDate()).padStart(2, '0');
//   var t_mm = String(tomorrow.getMonth() + 1).padStart(2, '0');
//   var t_yyyy = tomorrow.getFullYear();
//   var yesterday = new Date(today);
//   yesterday.setDate(today.getDate() - 1);
//   var y_dd = String(yesterday.getDate()).padStart(2, '0');
//   var y_mm = String(yesterday.getMonth() + 1).padStart(2, '0');
//   var y_yyyy = yesterday.getFullYear();
//   var YM = yyyy + '-' + mm;
//   var YESTERDAY = y_yyyy + '-' + y_mm + '-' + y_dd;
//   var TODAY = yyyy + '-' + mm + '-' + dd;
//   var calendarEl = document.getElementById('calendar');
//   var calendar = new FullCalendar.Calendar(calendarEl, {
//     initialView: 'dayGridMonth',
//     timeZone: 'UTC',
//     // themeSystem: 'bootstrap',
//     headerToolbar: {
//       left: 'title,prev,next',
//       center: null,
//       right: 'today,dayGridMonth,timeGridWeek,timeGridDay,listWeek'
//     },
//     height: 800,
//     contentHeight: 780,
//     aspectRatio: 3,
//     editable: true,
//     droppable: true,
//     direction: "ltr",
//     nowIndicator: true,
//     now: TODAY + 'T09:25:00',
//     views: {
//       listWeek: {
//         eventTimeFormat: { // like '14:30:00'
//           hour: '2-digit'
//         }
//       },
//       dayGridMonth: {
//         titleFormat: { // will produce something like "Tuesday, September 18, 2018"
//           month: 'long',
//           year: 'numeric'
//         },
//         dayMaxEventRows: 2
//       }
//       // timeGridWeek: {
//       //   titleFormat: ((date) => {
//       //     return moment(date.marker).format("MMM D")
//       //   })
//       // }
//     },
//     googleCalendarApiKey: 'AIzaSyDDeFkbj0RUSP7_v4JfGc_gtAC-tJWeWGM',
//     events: {
//       googleCalendarId: '70knbvand2fmsj8tir8s40tvgo@group.calendar.google.com'
//       // googleCalendarId: 'yair.facio@apptegy.com'
//     },
//     displayEventTime: false,

//   });
//   calendar.render();
// });


// function getEvents() {
//   let events = #{raw @event_list.items}
// }
