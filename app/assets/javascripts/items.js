$(document).ready(function(){
  $('.item-photo').slick({
    dots: true,
    infinite: false,
    arrows: false,
    slidesToShow: 1,
    pauseOnDotsHover: true,
    customPaging: function(slider, i) {
      var thumbSrc = $(slider.$slides[i]).attr('src');
      return '<img src="' + thumbSrc + '">';
    }
  });
  $('.slick-dots li').on({'mouseenter' : function(){
    var i = $(this).index();
    $('.item-photo').slick('slickGoTo', i, false);}
  });
});

