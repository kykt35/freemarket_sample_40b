$(document).ready(function(){
  $(".slider").slick({
    autoplay:true,
    autoplaySpeed:5000,
    dots:true,
    pauseOnDotsHover:true,
    focusOnSelect:false,
    prevArrow: '<img src="../assets/carousel-prev.png" class="slide-arrow prev-arrow">',
    nextArrow: '<img src = "../assets/carousel-next.png" class="slide-arrow next-arrow">'
  });
  $('.slick-dots li').on({'mouseenter' : function(){
    var i = $(this).index();
    console.log("dot");
    $('.slider').slick('slickGoTo', i, false);}
  });
});

