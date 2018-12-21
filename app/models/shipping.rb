class Shipping < ApplicationRecord
  has_many :items
  has_many :postage_selects_shippings, dependent :destroy
  has_many :postage_select, through: :postage_selects_shippings
end
