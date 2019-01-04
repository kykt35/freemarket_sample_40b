class CreditsController < ApplicationController

include Card

  def index
  end

  def new
    if current_user.credits.first.present?
      redirect_to mypage_card_path
    end
  end

  def create
    unless current_user.credits.present?  #もし現在のユーザーがクレジットカードを登録していないから
      @credit = current_user.credits.new(customer_id: create_customer) #token.idのcustomerのidを取得し、Creditモデルのカラムのcustomer_idと定義する
        if @credit.save
         redirect_to mypage_card_path
         else
          render 'new' # カード未登録で保存に失敗
        end
    else
      render 'new' # カード登録ずみ
    end

  end

 private
  def credit_params
    params.permit(:credit).permit(:user_id, :customer_id)
  end
end

