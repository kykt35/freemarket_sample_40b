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



    // 配送料の負担選択で配送方法
  $(document).on("change", "#item_postage_select_id", function (e) {
    e.preventDefault();
    var ps_id = $('#item_postage_select_id option:selected').val()
    if (ps_id == ""){
      $('#item_shipping_id').closest('.form-group').remove();
      return;
    }
    $.ajax({
      type: "GET",
      url: '/postage_selects',
      data: {id: ps_id},
      dataType: 'json',
      processData: true,
      contentType: false,
      timeout: 60000
    })
    .done(function(datas){
      if ( $('#item_shipping_id').length == 0){
        var formgroup =
          `<div class="form-group">
            <label for="item_shipping_id">配送方法
              <span class="form-require">必須</span>
            </label>
            <div class="select-wrap">
              <select class="select-default" name="item[shipping_id]" id="item_shipping_id">
                <option value="">---</option>
              </select>
              <i class="fa fa-angle-down"></i>
            </div>
            <ul class="has-error-text">
            </ul>
          </div>`
        options = datas.map(function(data){
          option = $('<option>',{value: data.id, text: data.text});
          return option;
        });
        $('#item_postage_select_id').parents('.form-group').after(formgroup
        );
        $('#item_shipping_id').append(options);

      }else{
        select = $('#item_shipping_id');
        select.children().remove()
        options = datas.map(function(data){
          option = $('<option>',{value: data.id, text: data.text});
          return option;
        });
        $('#item_shipping_id').append(options);
      }
    })
    .fail(function(){
      console.log("fail");
    })
  });
});
