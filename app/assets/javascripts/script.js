document.addEventListener("DOMContentLoaded", function() {
  let createEventLink = document.getElementById('create-event-link');
  let menu = document.querySelector('.menu');
  let closeBtn = document.querySelector('.menu .menu_btn');

  createEventLink.addEventListener('click', function(e) {
    e.preventDefault(); // Empêche le comportement de lien par défaut

    closeBtn.style.display = "block";
    menu.style.width = "100%";
    document.body.style.overflow = "hidden";
  });
});
