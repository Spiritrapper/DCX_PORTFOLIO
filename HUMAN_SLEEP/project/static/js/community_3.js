function readMore(cardId) {
    var moreText = document.getElementById(cardId).getElementsByClassName("more")[0];
    var dots = document.getElementById(cardId).getElementsByClassName("dots")[0];
    var btnText = document.getElementById(cardId).getElementsByClassName("myBtn")[0];
    
    if (dots.style.display === "none") {
      dots.style.display = "inline";
      moreText.style.display = "none";
      btnText.innerHTML = "Read more";
    } else {
      dots.style.display = "none";
      moreText.style.display = "inline";
      btnText.innerHTML = "Read less";
    }
  }