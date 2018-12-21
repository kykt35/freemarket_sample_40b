$(document).on('turbolinks:load', function() {
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

  // カテゴリセレクトでサブカテゴリ追加
  $('#item_l_category_id').on('change',function(e){
    e.preventDefault();
    var category_id = $('#item_l_category_id option:selected').val()
    if (category_id == ""){
      $('#item_m_category_id').parent().remove();
      $('#item_category_id').parent().remove();
      return;
    }
    $.ajax({
      type: "GET",
      url: '/categories',
      data: {id: category_id},
      dataType: 'json',
      processData: true,
      contentType: false,
      timeout: 60000
    })
    .done(function(categories){
      if ($('#item_category_id').length !=0) {
        $('#item_category_id').parent().remove();
      }
      if ($('#item_m_category_id').length == 0){
        var selectWrap =$('<div>',{class: 'select-wrap'});
        var select = $('<select>',{class: "select-default", name: "item[m_category_id]", id:  "item_m_category_id"});
        select.append(`<option value >---</option>`);
        options = categories.map(function(category){
          option = $('<option>',{value: category.id, text: category.name});
          return option;
        });
        selectWrap.append(select.append(options));
        selectWrap.append($('<i>',{class: 'fa fa-angle-down'}));
        $('#item_l_category_id').parent().parent().append(selectWrap);
      } else {
        select = $('#item_m_category_id');
        select.children().remove()
        select.append(`<option value >---</option>`);
        options = categories.map(function(category){
          option = $('<option>',{value: category.id, text: category.name});
          return option;
        });
        select.append(options);
      }
    })
    .fail(function(){
      console.log("fail");
    })
  });

  // カテゴリセレクトでサブサブカテゴリ追加
  $(document).on("change", "#item_m_category_id", function (e) {
    e.preventDefault();
    var category_id = $('#item_m_category_id option:selected').val()
    if (category_id == ""){
      $('#item_category_id').parent().remove();
      return;
    }
    $.ajax({
      type: "GET",
      url: '/categories',
      data: {id: category_id},
      dataType: 'json',
      processData: true,
      contentType: false,
      timeout: 60000
    })
    .done(function(categories){
      if ( $('#item_category_id').length == 0){
        var selectWrap =$('<div>',{class: 'select-wrap'});
        var select = $('<select>',{class: "select-default", name: "item[category_id]", id:  "item_category_id"});
        select.append(`<option value >---</option>`);
        options = categories.map(function(category){
          option = $('<option>',{value: category.id, text: category.name});
          return option;
        });
        selectWrap.append(select.append(options));
        selectWrap.append($('<i>',{class: 'fa fa-angle-down'}));
        $('#item_m_category_id').parent().parent().append(selectWrap);
      } else {
        select = $('#item_category_id');
        select.children().remove()
        select.append(`<option value >---</option>`);
        options = categories.map(function(category){
          option = $('<option>',{value: category.id, text: category.name});
          return option;
        });
        select.append(options);
      }
    })
    .fail(function(){
      console.log("fail");
    })
  });
});
