$(document).on('turbolinks:load', function() {
  $(function (){
      var price = $(".item-price").children('input').val();
      var amount = $("#exist-sales-amount").children('input').val();
    $('#sales-price-form').on('input', function(){
      var point = document.getElementById('sales-price-form').value;
      var calculate = (price - point);
      var result = calculate.toLocaleString();
      var SumPriceEmpty = $('#sum-price').empty('');
      var remaining = (amount - point);
      if ((point >= 0) && (calculate >= 50) && (remaining >= 0)) {
        SumPriceEmpty;
        $('#sum-price').html("¥ " + result);
        $('#exist-sales-amount').html("売上金が¥" + remaining + "あります");
      } else {
        SumPriceEmpty;
        $('#sum-price').html("---");
        $('#exist-sales-amount').html("---");
      }
    });
  });
});
