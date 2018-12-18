class ItemsController < ApplicationController
  def new
    @item = Item.new()
    #商品登録
  end
  def create
    @item = Item.create(item_params)
    if @item.valid?
      respond_to do |format|
        format.html
        format.json
      end
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :brand_id, :size_id, :item_condition_id, :postage_select_id, :shipping_id, :prefecture_id,:leadtime_id, :price, images: []).merge(seller_id: current_user.id)
  end

end
