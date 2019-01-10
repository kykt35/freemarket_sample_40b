class Favorite < ApplicationRecord
  belongs_to :item
  belongs_to :user
  validates :item_id, :user_id, presence: true
end
