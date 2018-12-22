class PostageSelect < ApplicationRecord
  has_many :items
  has_many :postage_selects_shippings, dependent: :destroy
  has_many :shippings, through: :postage_selects_shippings
end
