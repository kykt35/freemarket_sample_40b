module Card

  Payjp.api_key = Rails.application.credentials.dig(:pay_jp, :secret_key)

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

  def charge(payment)
    customer = current_user.credits.first.customer_id
    charge = Payjp::Charge.create(
      :amount => payment,
      :currency => 'jpy',
      :customer => customer
      )
  end

end

