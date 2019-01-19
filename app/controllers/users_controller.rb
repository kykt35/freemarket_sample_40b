class UsersController < ApplicationController

	def mypage
    @item_transactions_during = ItemTransaction.where(user: current_user, status: 0..4).reverse_order.page(params[:page]).per(4)
    @item_transactions_post = ItemTransaction.where(user: current_user, status: "finish").reverse_order.page(params[:page]).per(4)
	end

	def card
	end

	def add
	end

  def signup
  end

  def logout
  end

  def identification
  end

	def profile
	end

  def registration_card
  end

  def favorite
    @favorites = current_user.favorites
  end

  def purchace
    @item_transactions = ItemTransaction.where(user: current_user, status: 0..4).reverse_order.page(params[:page]).per(4)
  end

  def purchaced
    @item_transactions = ItemTransaction.where(user: current_user, status: "finish").reverse_order.page(params[:page]).per(4)
  end
end
