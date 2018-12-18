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
end
