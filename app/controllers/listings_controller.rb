class ListingsController < ApplicationController
  def index

  end

  def listing
    @items = current_user.items.includes(:favorites, :comments).where(status: "listing").reverse_order.page(params[:page]).per(4)
  end
  def in_progress
    @items = current_user.items.where(status: "in_progress").where(status: "listing").reverse_order.page(params[:page]).per(4)
  end
  def sold
    @items = current_user.items.where(status: "sold").where(status: "listing").reverse_order.page(params[:page]).per(4)
  end
end
