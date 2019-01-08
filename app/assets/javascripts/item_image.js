$(document).on('turbolinks:load', function() {
  var blob = null;

  function buildItemHTML(imageFile,key){
    var reader = new FileReader();
    var upload_items = $('.sell-upload-items ul li')
    var item_image =
      `<li class="sell-upload-item upload-item-${upload_items.length + 1}">
        <input name="item[uploaded_images][]" value=${key} type="hidden" id="item_uploaded_image">
        <figure class="sell-upload-figure">
          <img src="" alt="" class="">
        </figure>
        <div class="sell-upload-button">
          <a href="" class="sell-upload-edit">編集</a>
          <a href="" class="sell-upload-delete">削除</a>
        </div>
      </li>`;

    reader.onload = (function(imageFile){
      return function(e){
        $('.sell-upload-dropbox').removeClass().addClass("sell-upload-dropbox clearfix");
        $('.sell-upload-dropbox').addClass("have-item-"+(upload_items.length+1));
        $('.sell-upload-items ul').append(item_image);
        $('.upload-item-'+ (upload_items.length + 1) + " img").attr("src", reader.result);
      };
    })(imageFile);
    reader.readAsDataURL(imageFile);
  }

  function uploadImage(imageFile){
    var formData = new FormData();
    formData.append('image', imageFile);
    $.ajax({
      type: "POST",
      url: '/items/upload_image',
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      buildItemHTML(imageFile, data.imageKey)
    })
    .fail(function(){
      alert('サーバーとの通信に失敗しました');
    })
  }

  function resizeImage(file) {
  const WIDTH = 360;
  const HEIGHT = 360;
  var img = new Image();
  var def =$.Deferred();
  var canvas = document.createElement('canvas');
  var reader = new FileReader();
  reader.onload = function(e){
    img.onload = function(){
      if(img.width > img.height){
        var ratio = img.height/img.width;
        width = WIDTH;
        height = HEIGHT * ratio;
      } else {
        var ratio = img.width/img.height;
        width = HEIGHT * ratio;
        height = HEIGHT;
      }

      // canvasに描写
      var ctx = canvas.getContext('2d');
      canvas.width = width;
      canvas.height = height;
      ctx.drawImage(img,0,0,width,height);

      // base64からBlobデータを作成
      var base64 = canvas.toDataURL('image/jpeg');
      var barr, bin, i, len;
      bin = atob(base64.split('base64,')[1]);
      len = bin.length;
      barr = new Uint8Array(len);
      i = 0;
      while (i < len) {
        barr[i] = bin.charCodeAt(i);
        i++;
      }
      blob = new Blob([barr], {type: 'image/jpeg'});
      def.resolve(canvas);
    };
    img.src = e.target.result;
  };
  reader.readAsDataURL(file);
  return def.promise();
  }

  $('.sell-upload-drop-file').on('change',function(e){
    var files = e.target.files;

    for (var i = 0; i < files.length; i++) {
      if ($('.sell-upload-item').length <= 10){
        file = files[i];
        resizeImage(file).then(function(){
          uploadImage(blob);
        });
      }
    }
    $('.sell-upload-drop-file').val('');
  });

  $("#sell-item-container").on("click", ".sell-upload-delete", function (e) {
    e.preventDefault();
    $(this).parents('.sell-upload-item').remove();
    var upload_item = $('.sell-upload-item');
    var num = upload_item.length;
    $('.sell-upload-items').removeClass().addClass("sell-upload-items have-item-" + num);
    $('.sell-upload-dropbox').removeClass().addClass("sell-upload-dropbox clearfix have-item-" + num);
    upload_item.each(function(index, element){
      $(element).removeClass().addClass("sell-upload-item upload-item-" + index);
    });
  });
});
