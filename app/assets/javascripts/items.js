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

  // 大カテゴリセレクトで中カテゴリ追加
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

  // 中カテゴリセレクトで小カテゴリ追加
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

    // 小カテゴリ選択で必要な時にサイズとブランドを表示
  $(document).on("change", "#item_category_id", function (e) {
    e.preventDefault();
    var category_id = $('#item_category_id option:selected').val()
    if (category_id == ""){
      $('#item_size_id').parent().parent().remove();
      $('#item_brand_id').parent().parent().remove();
      return;
    }
    $.ajax({
      type: "GET",
      url: '/categories/size_brand',
      data: {id: category_id},
      dataType: 'json',
      processData: true,
      contentType: false,
      timeout: 60000
    })
    .done(function(datas){
      console.log("done");
      if ( $('#item_size_id').length == 0){
        var formgroup =
          `<div class="form-group form-group-size">
            <label for="item_size_id">サイズ
              <span class="form-require">必須</span>
            </label>
            <div class="select-wrap">
              <select class="select-default" name="item[size_id]" id="item_size_id">
                <option value="">---</option>
              </select>
              <i class="fa fa-angle-down"></i>
            </div>
            <ul class="has-error-text">
            </ul>
          </div>`
        options = datas.size.map(function(data){
          option = $('<option>',{value: data.id, text: data.name});
          return option;
        });
        $('.form-group-category').after(formgroup);
        $('#item_size_id').append(options);

        if (datas.hasBrand){
          var formgroup =
            `<div class="form-group form-group-brand">
              <label for="item_brand_id">ブランド
                <span class="form-arbitrary">任意</span>
              </label>
              <div class="select-wrap">
                <input class="input-default" id="item_brand" value="" placeholder="例）シャネル">
              </div>
            </div>`
          $('.form-group-item_condition').before(formgroup);
        }
      }else{

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
          `<div class="form-group form-group-shipping">
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
        select.append(`<option value >---</option>`);
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

  //価格入力時に手数料、収益を表示
  $(document).on("keyup", "#item_price", function (e) {
    var price = Number($(this).val());
    if ((price >= 300) && (price < 10000000)) {
      var fee =0.1; //手数料 10％
      var commission = Math.floor(price * fee);
      var profit = (price - commission);
      $('.sell-commission-value').text("¥"+commission.toLocaleString());
      $('.sell-profit-value').text("¥"+profit.toLocaleString());
    } else {
      $('.sell-commission-value').text("-");
      $('.sell-profit-value').text("-");
    }
  });
});
