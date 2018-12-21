class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @item = Item.new()
    #商品登録
  end
  def create
    @item = Item.new(item_params)
    if @item.save
      respond_to do |format|
        format.html
        format.json
      end
    else
      render :new
    end
  end

  def show
     @item = Item.find(params[:id])
  end

    def edit
      @item = Item.find(params[:id])
    end

    def update
      @item = Item.find(params[:id])
      @item.update(item_params)
      redirect_to  item_path
    end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :brand_id, :size_id, :item_condition_id, :postage_select_id, :shipping_id, :prefecture_id,:leadtime_id, :price, images: []).merge(seller_id: current_user.id)
  end

end
