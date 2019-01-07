class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]
  before_action :set_item, only: [:show, :edit, :update]

  def new
    @item = Item.new()
    #商品登録
  end

  def create
    @item = Item.new(item_params)
    uploaded_images.each {|image| @item.images.attach(image)} if uploaded_images.present?
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
    @item =Item.find(params[:id])
    @comments = @item.comments.includes(:user)
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item), notice: 'アイテムを編集しました。'
    else
      render :edit
    end
  end

  def search
    #キーワードで検索
    @select = params[:order]
    if @select.present?
      order = params[:order].sub(/_desc/," "+"DESC")
    end
    @items = Item.includes([:category, :size, :item_condition, :shipping, :postage_select]).where('name LIKE(?)', "%#{params[:search]}%").order(order)
    @value = params[:search]
    # カテゴリーで検索
    @search_l = params[:search_item_l_category_id]
    @search_m = params[:search_item_m_category_id]
    @search = params[:search_item_category_id]
    if @search.present?
      @items = @items.where(category_id: params[:search_item_category_id])
    elsif @search_m.present?
      @items = @items.where(m_category_id: params[:search_item_m_category_id])
    elsif @search_l.present?
      @items = @items.where(l_category_id: params[:search_item_l_category_id])
    end
    # ブランド名で検索
    @brand_name = params[:brand]
    if @brand_name.present?
      @items = @items.where(brand: params[:brand])
    end
    # サイズで検索
    # 保留
    # 値段で検索
    @price_tag = params[:price_tag]
    @min = params[:min_price]
    @max = params[:max_price]
      respond_to do |format|
        format.html
        format.json{
          @price_tag  = ItemPrice.find(params[:price_tag_id])
        }
      end
    if @min.present?||@max.present?
      @items = @items.where('price >= ?', @min).where('price <= ?', @max)
    end
    # 商品状態
    @item_condition_ids = params[:item_condition_id]
    if @item_condition_ids.present?
      @items = @items.where(item_condition_id: @item_condition_ids)
    end
    # 配送料金
    @postage_select_ids = params[:postage_select_id]
    if @postage_select_ids.present?
      @items = @items.where(postage_select_id: @postage_select_ids)
    end
    # 在庫
    @status = ["販売中","売り切れ"]
    @stock_select_ids = params[:stock_select_id]
    if @stock_select_ids.present?
      # @items = @items.where(status: @stock_select_ids)
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy if user_signed_in? && item.seller_id == current_user.id
    redirect_to root_path
  end

  def upload_image
    #Active StrageのBlobを返す
    if user_signed_in?
      @image_blob = create_blob(params[:image])
      respond_to do |format|
        format.json { @image_blob }
      end
    else
      respond_to do |format|
        format.json {
          render status: 401, json: { status: 401, message: 'Unauthorized' }
        }
      end
    end
  end


  private

  def item_params
    params.require(:item).permit(:name, :description, :l_category_id,:m_category_id,:category_id, :brand_id, :size_id, :item_condition_id, :postage_select_id, :shipping_id, :prefecture_id,:leadtime_id, :price).merge(seller_id: current_user.id)
  end
  def uploaded_images
    # ActiveStorage::Blob objectを返す
    params[:item][:uploaded_images].map{|key| ActiveStorage::Blob.find_by(key: key)} if params[:item][:uploaded_images]
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def create_blob(uploading_file)
    ActiveStorage::Blob.create_after_upload! \
      io: uploading_file.open,
      filename: uploading_file.original_filename,
      content_type: uploading_file.content_type
  end
end
