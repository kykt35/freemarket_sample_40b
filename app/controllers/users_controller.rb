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

end
