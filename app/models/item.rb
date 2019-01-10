class Item < ApplicationRecord
  has_many_attached :images
  has_many :comments
  has_many :favorites, dependent: :destroy
  belongs_to :seller, class_name: "User"
  belongs_to :category
  belongs_to :size, optional: true
  belongs_to :item_condition
  belongs_to :shipping
  belongs_to :postage_select
  belongs_to :leadtime
  belongs_to :prefecture
  has_many :item_transactions
  enum status:[:listing, :sold, :in_progress, :finished, :freezed]
  validates :name, :description, :category_id, :item_condition_id, :postage_select_id, :shipping_id, :prefecture_id, :leadtime_id, :price, :seller_id, presence: true
  validates :price, numericality: { only_integer: true }
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validate :images_attached
  validate :images_validate
  validates :images, length: { maximum: 10 }


  #いいねする
  def favorite(user)
    favorites.create(user_id: user.id)
  end
  #いいねをやめる
  def unfavorite(user)
    favorites.find_by(user_id: user.id).destroy
  end
  #いいねしたか確認する
  def favorited?(user)
    favorites.find_by(user_id: user.id) if user.present?
  end
  #サイズの組み分け
  def self.size_sort(category)
    if category.id<=56
      ["レディース/"+category.name + "のサイズ", category.id]
    elsif category.id<=199
      ["メンズ/"+ category.name + "のサイズ", category.id]
    else
      [category.name+"のサイズ",category.id]
    end
  end

  def self.item_status_search(params,items)
    stock_select_ids = params[:stock_select_id]
    if stock_select_ids.present?
      items = items.where(status: stock_select_ids)
    end
    return items, stock_select_ids
  end

  private

  #カスタムバリデーション
  def images_attached
    errors.add(:images, "images cant' be blank") unless images.attached?
  end

  def images_validate
    images.each do |image|
      if not is_image(image.blob)
        errors.add(:images,'jpg/png only')
        break
      elsif image.blob.byte_size > 10.megabytes
        errors.add(:images, 'too large')
        break
      end
    end
  end

  def is_image(blob)
    %w[image/jpg image/jpeg image/png].include?(blob.content_type)
  end
end

