class ItemsController < ApplicationController
  def new
    #商品登録
  end
  def create
    @item = Item.new(item_params)
    if @item.save
      respond_to do |format|
        format.html { render :new}
        format.json
      end
  end
end
