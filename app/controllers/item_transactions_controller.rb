class ItemTransactionsController < ApplicationController
    before_action :set_item, only: [:new, :pay]
  def new
  end

  def create
    @item = Item.find(params[:id])
    price = @item.price
    if current_user && current_user.credits.present
       charge(price)
    end
    @item_transaction = ItemTransaction.new(order_params)
    @sales = Sales.new(price: price * 0.9, limit_time: Date.today() + "180", user_id: @item.user_id)
    redirect_to root_path, notice: 'ありがとうございました。'
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  private
  def order_params
    params.permit(:order).permit(:item_id, :customer_id)
  end
end
