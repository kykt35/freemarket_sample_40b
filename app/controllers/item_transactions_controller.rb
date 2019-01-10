class ItemTransactionsController < ApplicationController
  require 'date'
  require 'bigdecimal'
  before_action :set_item, only: [:new, :create, :show]
  before_action :set_sales_amount, only: [:create, :show]
  before_action :set_item_transactions, only: [:show]
  include Card

  def new
    @item_transaction = @item.item_transactions.build()
    @sales_amount = SalesAmount.new()
  end

  def create
      if @sales_amount.price > 50
        if current_user.sales_amounts.present? && current_user.sales_amounts.sum(:price) - current_user.item_transactions.sum(:point) > 0
          @item_transaction = @item.item_transactions.build(item_id: @item.id, user_id: current_user.id, point: params[:point])
          @item_transaction.point = 0 if @item_transaction.point.nil?
          payment = @item.price - @item_transaction.point
          charge(payment) #card.rbで定義したメソッドを呼び出している
        else
          @item_transaction = @item.item_transactions.build(item_id: @item.id, user_id: current_user.id, point: 0)
          price = @item.price
          charge(price)
        end
      else
          render :new
      end

      if @item_transaction.save && @sales_amount.save
        @item_transaction.item.update_attribute(:status, 1)
        redirect_to  item_item_transaction_path(@item, @item_transaction)
      else
          render :new
      end
  end

  def show

  end

  private

    def set_item
      @item = Item.find(params[:item_id])
    end

    def set_item_transactions
      @item_transaction = @item.item_transactions.find(params[:id])
    end

    def set_sales_amount
      @sales_amount = SalesAmount.new(price: (@item.price * BigDecimal("0.9")).ceil, limit_date: Date.today() + 180, user_id: @item.seller_id)
    end
end
