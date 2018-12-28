class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @item = Item.find(params[:item_id])
    @item.like(current_user)
  end

  def destroy
    @item =Item.find(params[:item_id])
    @item.unlike(current_user);
  end
end
