$(document).on('turbolinks:load', function() {
  $(function SumPrice(){
    $('#sales-price-form').on('input', function(){
    var point = document.getElementById('sales-price-form').value;
    var price = $(".item-price").children('input').val();
    var amount = $("#exist-sales-amount").children('input').val();
    var calculate = (price - point);
    var result = calculate.toLocaleString();
    if ((point >= 0) && (calculate >= 0) && (amount >=  point)) {
      $('#sum-price').empty('');
      $('#sum-price').html("¥" + result);
    } else {
      $('#sum-price').empty('');
      $('#sum-price').html("¥ " + price);
      }
    });
  });
});
