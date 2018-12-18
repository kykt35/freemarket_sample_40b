class Item < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  belongs_to :brand
  belongs_to :category
  belongs_to :size
  belongs_to :item_condition
  belongs_to :shipping
  belongs_to :postage_select
  belongs_to :leadtime
  belongs_to :prefecture
end
