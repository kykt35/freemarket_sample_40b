class UsersController < ApplicationController

	def mypage
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
  end

  def purchaced
    @item_transactions = ItemTransaction.where(user: current_user).reverse_order.page(params[:page]).per(4)
  end
end
