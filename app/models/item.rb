class Item < ApplicationRecord
  has_many_attached :images
  belongs_to :seller, class_name: "User"
  belongs_to :category
  belongs_to :size, optional: true
  belongs_to :item_condition
  belongs_to :shipping
  belongs_to :postage_select
  belongs_to :leadtime
  belongs_to :prefecture
  validates :name, :description, :category_id, :item_condition_id, :postage_select_id, :shipping_id, :prefecture_id, :leadtime_id, :price, :seller_id, presence: true
  validates :price, numericality: { only_integer: true }
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validate :images_attached
  validate :images_validate
  validates :images, length: { maximum: 10 }

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
