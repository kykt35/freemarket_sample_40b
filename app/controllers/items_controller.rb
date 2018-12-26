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

  def destroy
    item = Item.find(params[:id])
    item.destroy if item.seller_id == current_user.id
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
