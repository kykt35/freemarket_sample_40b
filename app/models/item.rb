class Item < ApplicationRecord
  has_many_attached :images
  belongs_to :seller, class_name: "User"
  belongs_to :brand, optional: true
  belongs_to :category
  belongs_to :size, optional: true
  belongs_to :item_condition
  belongs_to :shipping
  belongs_to :postage_select
  belongs_to :leadtime
  belongs_to :prefecture
  validates :name, :description, :category_id, :item_condition_id, :postage_select_id, :shipping_id, :prefecture_id, :leadtime_id, :price, :seller_id, presence: true
  validates :price, only_integer: true
end
