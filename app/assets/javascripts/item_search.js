// 並び替え選択でフォーム送信
$(document).on("change", "#order", function (e){
  $("#search-form").submit();
});
// 大カテゴリセレクトで中カテゴリ追加
$(document).on("change",'#search_item_l_category_id',function(e){
  e.preventDefault();
  var category_id = $('#search_item_l_category_id option:selected').val()
  if (category_id == ""){
    $('#search_item_m_category_id').parent().remove();
    $('#search_item_category_id').parent().remove();
  } else {
    $.ajax({
      type: "GET",
      url: '/categories',
      data: {id: category_id},
      dataType: 'json',
      timeout: 60000
    })
    .done(function(categories){
      if ($('#search_item_category_id').length !=0) {
        $('#search_item_category_id').parent().remove();
      }
      if ($('#search_item_m_category_id').length == 0){
        var selectWrap =$('<div>',{class: 'select-wrap'});
        var select = $('<select>',{class: "select-default", name: "search_item_m_category_id", id:  "search_item_m_category_id"});
        select.append(`<option value >---</option>`);
        options = categories.map(function(category){
          option = $('<option>',{value: category.id, text: category.name});
          return option;
        });
        selectWrap.append(select.append(options));
        selectWrap.append($('<i>',{class: 'fa fa-angle-down'}));
        $('#search_item_l_category_id').parent().parent().append(selectWrap);
      } else {
        select = $('#search_item_m_category_id');
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
      alert("fail");
    })
  }
})
// 中カテゴリセレクトで小カテゴリ追加
$(document).on("change", "#search_item_m_category_id", function (e) {
  e.preventDefault();
  var category_id = $('#search_item_m_category_id option:selected').val()
  if (category_id == ""){
    $('#search_item_category_id').parent().remove();
  } else {
    $.ajax({
      type: "GET",
      url: '/categories',
      data: {id: category_id},
      dataType: 'json',
      timeout: 60000
    })
    .done(function(categories){
      if ( $('#search_item_category_id').length == 0){
        var selectWrap =$('<div>',{class: 'select-wrap'});
        var select = $('<select>',{class: "select-default", name: "search_item_category_id", id:  "search_item_category_id"});
        select.append(`<option value >---</option>`);
        options = categories.map(function(category){
          option = $('<option>',{value: category.id, text: category.name});
          return option;
        });
        selectWrap.append(select.append(options));
        selectWrap.append($('<i>',{class: 'fa fa-angle-down'}));
        $('#search_item_m_category_id').parent().parent().append(selectWrap);
      } else {
        select = $('#search_item_category_id');
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
      alert("fail");
    })
  }
});
// サイズセレクトでチェックボックス追加
$(document).on("change", "#category_size",function(e){
  e.preventDefault();
  var category_size_id = $("#category_size option:selected").val()
  if(category_size_id ==""){
    $("#size-checkbox-area").empty();
  } else {
    $.ajax({
      type: "GET",
      url: "/items/search_material",
      data: {category_size_id: category_size_id},
      dataType: 'json',
      timeout: 60000
    })
    .done(function(category_size_ids){
      $("#size-checkbox-area").empty();
      function buildSizeHtml(size){
        html =`<div class="checkbox-default">
                <label>
                  <input id="size_id_${size.id}" class="check-btn size-check-btn" type="checkbox" value=${size.id} name="size_id[]">
                  <p class="checkbox-label">${size.name}</p>
                </label>
              </div>`
        return html
      }
      $("#size-checkbox-area").append(`<div class="checkbox-default">
                                        <label>
                                          <input class="check-btn size_check-btn" id="size_all" type="checkbox">
                                          <p class="checkbox-label">すべて</p>
                                        </label>
                                      </div>`);
      category_size_ids.forEach(function(category_size_id){
        $("#size-checkbox-area").append(buildSizeHtml(category_size_id));
      })
    })
    .fail(function(){
      alert("fail");
    })
  }
})
// 値段セレクトボックス選択で、numberfiledに代入
$(document).on("change", "#price_tag", function (e){
  e.preventDefault();
  var price_tag_id = $('#price_tag option:selected').val()

  if (price_tag_id == ""){
    $('#min_price').val("");
    $('#max_price').val("");
  }else {
    $.ajax({
      type: "GET",
      url: "/items/search_material",
      data: {price_tag_id: price_tag_id},
      dataType: 'json',
      timeout: 60000
    })
    .done(function(price_tag){
      $('#min_price').val(price_tag.min_price)
      $('#max_price').val(price_tag.max_price)
    })
    .fail(function(){
      alert("fail");
    })
  }
});
// numberfieldクリックで、値段フォームとnunberfieldリセット
  $(document).on("click", "#min_price,#max_price", function (e){
  e.preventDefault();
  var price_select_id = $("#price_tag option:selected").val();
  if (price_select_id !== "") {
  $("#price_tag option").attr("selected", false);
  $('#min_price').val("");
  $('#max_price').val("");
  }
});
// すべてをチェックすると全選択/全解除
// サイズ
  $(document).on("click", "#size_all", function (){
  var checked = $("#size_all").prop("checked")
  if (checked==true) {
    $(".size-check-btn").prop("checked", true)
  }else{
    $(".size-check-btn").prop("checked", false);
  }
});
// 商品状態
  $(document).on("click", "#condition_all", function (){
  var checked = $("#condition_all").prop("checked")
  if (checked==true) {
    $(".condition-check-btn").prop("checked", true)
  }else{
    $(".condition-check-btn").prop("checked", false);
  }
});
// 送料
  $(document).on("click", "#postage_select_all", function (){
    var checked = $("#postage_select_all").prop("checked")
  if (checked==true) {
    $(".postage-check-btn").prop("checked", true)
  }else{
    $(".postage-check-btn").prop("checked", false);
  }
});
// 在庫状況
  $(document).on("click", "#stock_all", function (){
  var checked = $("#stock_all").prop("checked")
  if (checked==true) {
    $(".stock-check-btn").prop("checked", true)
  }else{
    $(".stock-check-btn").prop("checked", false);
  }
});
