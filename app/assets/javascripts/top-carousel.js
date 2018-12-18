$(document).ready(function(){
  $(".slider").slick({
    autoplay:true,
    autoplaySpeed:5000,
    dots:true,
    pauseOnDotsHover:true,
    focusOnSelect:true,
    arrows: false,
    appendArrows: $('#arrows')
  });
  $('.slick-dots li').on({'mouseenter' : function(){
    var i = $(this).index();
    $('.slider').slick('slickGoTo', i, false);}
  });
  $('.slick-next').on('click', function () {
     $('.slider').slick('slickNext');
  });
  $('.slick-prev').on('click', function () {
    $('.slider').slick('slickPrev');
    });
});