class CreditsController < ApplicationController
  before_action :credit_confirm, only: [:new, :create]
  include Card

  def index
  end

  def new
    @credit = current_user.credits.new()
  end

  def create
    @credit = current_user.credits.new(customer_id: create_customer) #token.idのcustomerのidを取得し、Creditモデルのカラムのcustomer_idと定義する
    if @credit.save
     redirect_to credits_path
    else
      render 'new' # カード未登録で保存に失敗
    end
  end

 private
  def credit_confirm
    if current_user.credits.present?  #もし現在のユーザーがクレジットカード登録ないなら
      redirect_to credits_path
    end
  end

end

