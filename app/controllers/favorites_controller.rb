class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @item = Item.find(params[:item_id])
    @item.favorite(current_user)
  end

  def destroy
    @item =Item.find(params[:item_id])
    @item.unfavorite(current_user)
  end
end
