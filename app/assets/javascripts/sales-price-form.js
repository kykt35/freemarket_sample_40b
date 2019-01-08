$(document).on('turbolinks:load', function() {
  $(function SumPrice(){
    $('#sales-price-form').on('input', function(){
    var point = document.getElementById('sales-price-form').value;
    var price = $(".item-price").children('input').val();
    var amount = $("#exist-sales-amount").children('input').val();
    var calculate = (price - point);
    var result = calculate.toLocaleString();
    var SumPriceEmpty = $('#sum-price').empty('');

    if ((point >= 0) && (calculate >= 0)) {
      SumPriceEmpty;
      $('#sum-price').html("¥" + result);
    } else {
      SumPriceEmpty;
      $('#sum-price').html("¥ " + price);
      }
    });
  });
});
