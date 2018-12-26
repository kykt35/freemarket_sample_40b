module Card

  Payjp.api_key = 'sk_test_ace09f07a75489d03d33a6d0'

  def create_customer
    year = "20" + params[:year].to_s
  token = Payjp::Token.create({
    :card => {
      :number => params[:number],
      :cvc => params[:cvc],
      :exp_month => params[:month],
      :exp_year => year
    }},
    {
      'X-Payjp-Direct-Token-Generate': 'true'
    }
  )
  customer_id = Payjp::Customer.create(:card => token.id).id
  end

  def charge(price)
    charge = Payjp::Charge.create(
      :amount => price,
      :currency => 'jpy',
      :customer => current_user.credits.first.customer_id
      )
  end

end

