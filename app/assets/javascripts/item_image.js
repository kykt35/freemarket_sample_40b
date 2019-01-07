$(document).on('turbolinks:load', function() {

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

    reader.onload = (function(imageFile){ /* コールバック関数 */
      return function(e){
        $('.sell-upload-dropbox').removeClass().addClass("sell-upload-dropbox clearfix");
        $('.sell-upload-dropbox').addClass("have-item-"+(upload_items.length+1));
        $('.sell-upload-items ul').append(item_image);
        $('.upload-item-'+ (upload_items.length + 1) + " img").attr("src", reader.result);
      };
    })(imageFile);
    reader.readAsDataURL(imageFile);
  }

  function uploadImage(imageFile){ /* コールバック関数を受け取っている */ /* ここから非同期で画像を表示する処理 */
    var formData = new FormData(this);
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

  $('.sell-upload-drop-file').on('change',function(e){
    var files = e.target.files;
    for (var i = 0; i < files.length; i++) {
      if ($('.sell-upload-item').length <= 10){
        uploadImage(files[i]);
      }
    }
    $('.sell-upload-drop-file').val('');
  });
/* ここまでは非同期で画像を表示する処理 */

/* ここからは削除機能ではない！笑 */
  $(document).on("click", ".sell-upload-delete", function (e) {
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

 
/* ここからは画像編集機能 */
  $(document).on("click", ".sell-upload-edit", function (e) {
    e.preventDefault();
    $('#modalArea').fadeIn();
  });
  $('#closeModal , #modalBg').click(function(){
    $('#modalArea').fadeOut();
  });

   onload = function() {
  draw();
};
function draw() {
  var canvas = document.getElementById('c1');
  if ( ! canvas || ! canvas.getContext ) { return false; }
  var ctx = canvas.getContext('2d');
  /* Imageオブジェクトを生成 */
  var img = new Image();
  img.src = "/images/sample.jpg?";
  img.onload = function() {
    ctx.drawImage(img, 0, 0);
}

const slider = document.getElementById('zoom-slider');

// スライダーが動いたら拡大・縮小して再描画する
slider.addEventListener('input', e => {
  // 一旦クリア 
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  // 倍率変更
  const scale = e.target.value;
  ctx.scale(scale, scale);
  // 再描画
  ctx.drawImage(img, 0, 0);
  // 変換マトリクスを元に戻す
  ctx.scale(1 / scale, 1 / scale);
    })

  let isDragging = false;
// ドラッグ開始位置
let start = {
  x: 0,
  y: 0
};
// ドラッグ中の位置
let diff = {
  x: 0,
  y: 0
};
// ドラッグ終了後の位置
let end = {
  x: 0,
  y: 0
}
const redraw = () => {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  ctx.drawImage(img, diff.x, diff.y)
};
canvas.addEventListener('mousedown', event => {
  isDragging = true;
  start.x = event.clientX;
  start.y = event.clientY;
});
canvas.addEventListener('mousemove', event => {
  if (isDragging) {
    diff.x = (event.clientX - start.x) + end.x;
    diff.y = (event.clientY - start.y) + end.y;
    redraw();
  }
});
canvas.addEventListener('mouseup', event => {
  isDragging = false;
  end.x = diff.x;
  end.y = diff.y;
});
  
  }
});
// const canvas = document.createElement('canvas');
// const ctx = canvas.getContext('2d');
// // document.getElementById('c1').appendChild(canvas);

// const img = new Image();
// img.src = '/images/sample.jpg';

// img.onload = () => {
//   // Canvasを画像のサイズに合わせる
//   canvas.height = img.height;
//   canvas.width  = img.width;
//   console.log(ctx.drawImage(img, 0, 0));
//   console.log(img.src);

//   // Canvasに描画する
//   ctx.drawImage(img, 0, 0);

// };

// img.onerror = () => {
//   console.log('画像の読み込み失敗');
// };







