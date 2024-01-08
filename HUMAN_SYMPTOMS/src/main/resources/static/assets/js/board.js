const toggleBtn = document.querySelector('.navbar_toggleBtn');
const menu1 = document.querySelector('.navbar_menu');
const icons1 = document.querySelector('.navbar_icons');

toggleBtn.addEventListener('click', () => {
  menu1.classList.toggle('active');
  icons1.classList.toggle('active');
});

/*// 클릭 이벤트 발생 시 body에 클래스를 추가하여 document에 클릭 이벤트를 추가
document.body.addEventListener('click', (event) => {
  if (!menu1.contains(event.target) && !toggleBtn.contains(event.target)) {
    menu1.classList.remove('active');
    icons1.classList.remove('active');
  }
});*/