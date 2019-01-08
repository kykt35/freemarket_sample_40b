class ItemTransactionsController < ApplicationController
  require 'date'
  before_action :set_item, only: [:new, :create]
  include Card

  def new
    @item_transaction = ItemTransaction.new()
    @sales_amount = SalesAmount.new()
  end

  def create
    @item_transaction = ItemTransaction.new(item_id: @item.id, user_id: current_user.id, point: params[:point])
    @sales_amount = SalesAmount.new(price: @item.price * 0.9, limit_date: Date.today() + 180, user_id: @item.seller_id)
    payment = @item.price - @item_transaction.point
    charge(payment) #card.rbで定義したメソッドを呼び出している
      if @item_transaction.save && @sales_amount.save
      @item_transaction.item.update_attribute(:status, 1)
      redirect_to root_path
      else
        render :new
      end
  end

  private
    def set_item
      @item = Item.find(params[:item_id])
    end
end
