class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]
  before_action :set_item, only: [:show, :edit, :update]

  def new
    @item = Item.new()
    #商品登録
    @l_category = Category.where(ancestry: nil)
    @item_condition = ItemCondition.all
    @postage_select = PostageSelect.all
    @prefecture = Prefecture.all
    @leadtime = Leadtime.all
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
      @l_category = Category.where(ancestry: nil)
      @m_category = Category.find(@item.l_category_id).children if @item.l_category_id
      @category = Category.find(@item.m_category_id).children if @item.m_category_id
      @item_condition = ItemCondition.all
      @postage_select = PostageSelect.all
      @prefecture = Prefecture.all
      @leadtime = Leadtime.all
      render :new
    end
  end

  def show
    @comments = @item.comments.includes(:user)
  end

  def edit
  end

  def update
    @item.images.detach #attachmentを一旦すべて解除
    uploaded_images.each {|image| @item.images.attach(image)} if uploaded_images.present?
    if @item.update(item_params)
      redirect_to item_path(@item), notice: 'アイテムを編集しました。'
    else
      render :edit
    end
  end

  def search
    # formのビューに必要なインスタンス変数
    @size_categories_ids = CategoriesSize.group(:category_id).having('count(*) >= 2').map{|sc| sc.category_id}
    @price_tag = params[:price_tag]
    @status = ["販売中","売り切れ"]
    #並べ替え
    @select = params[:order]
    if @select.present?
      order = params[:order].sub(/_desc/," "+"DESC")
    end
    #キーワードで検索
    @value = params[:search]
    @items = Item.all
    @items = Item.where('name LIKE(?)', "%#{params[:search]}%").order(order)
    # カテゴリーで検索
    @items, @search_l, @search_m, @search = Category.item_search(params,@items)
    # ブランド名で検索
    @items, @brand_name = Brand.item_search(params,@items)
    # サイズで検索
    @items, @category_size, @size_ids, @category_sizes_ids = Size.item_search(params,@items)
    # 値段で検索
    @items, @min, @max = ItemPrice.item_search(params,@items)
    # 商品状態
    @items, @item_condition_ids = ItemCondition.item_search(params,@items)
    # 配送料金
    @items, @postage_select_ids = PostageSelect.item_search(params,@items)
    # 在庫
    @items, @stock_select_ids = Item.item_status_search(params,@items)
    @items = @items.with_attached_images.includes(:favorites).page(params[:page]).per(20)
  end

  def get_search_material
    respond_to do |format|
      format.html
      if params[:price_tag_id].present?
        format.json{
          @price_tag  = ItemPrice.find(params[:price_tag_id])
        }
      elsif params[:category_size_id].present?
        format.json{
          @category_sizes_ids = CategoriesSize.where(category_id: params[:category_size_id])
        }
      elsif params[:brand_category_id].present?
        format.json{
          @brands_categories_ids = BrandsCategory.includes(:brand).where(category_id: params[:brand_category_id])
        }
      elsif params[:brand_category_id].blank?&&params[:brand_name].present?
        format.json{
          @brands = Brand.where('name LIKE(?)', "#{params[:brand_name]}%")
        }
      end
    end
  end

  def set_item
    @item = Item.find(params[:id]).with_attached_image
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
    params.require(:item).permit(:name, :description, :status, :l_category_id,:m_category_id,:category_id, :brand_id, :size_id, :item_condition_id, :postage_select_id, :shipping_id, :prefecture_id,:leadtime_id, :price).merge(seller_id: current_user.id)
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
