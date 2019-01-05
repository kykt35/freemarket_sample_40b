class ItemTransactionsController < ApplicationController
  before_action :set_item, only: [:new, :create]
  include Card

  def new
    @item_transaction = ItemTransaction.new()
  end

  def create
    @item_transaction = ItemTransaction.new(item_id: @item.id, user_id: current_user.id)
    price = @item.price
    charge(price)
      if @item_transaction.save
      # @sales_amount = SalesAmount.new(price: price * 0.9, limit_time: Date.today() + "180", user_id: @item.user_id)
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
