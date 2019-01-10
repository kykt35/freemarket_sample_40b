class CreditsController < ApplicationController
  include Card

  def index
    @credit = current_user.credits.first
  end

  def new
    @credit = current_user.credits.new()
  end

  def create
    @credit = current_user.credits.new(customer_id: create_customer) #token.idのcustomerのidを取得し、Creditモデルのカラムのcustomer_idと定義する
    if @credit.save
      flash.now[:success] = 'カードが登録されました。'
      redirect_to credits_path
    else
      render 'new' # カード未登録で保存に失敗
    end
  end

  def destroy
    credit = current_user.credits.first
    credit.destroy if user_signed_in? && current_user.credits.present?
    flash.now[:success] = 'カードが削除されました。'
    redirect_to credits_path
  end

end

