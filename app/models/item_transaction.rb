class ItemTransaction < ApplicationRecord
  belongs_to :item
  belongs_to :user
  validates :point, null: false, presence: true
end
