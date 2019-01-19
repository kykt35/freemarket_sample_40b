class ItemTransaction < ApplicationRecord
  belongs_to :item
  belongs_to :user
  validates :point, null: false, presence: true
  enum status:{ waiting_for_shipping: 0,
                shipping: 1,
                wait_for_recieve: 2,
                recieved: 3,
                evaluation: 4,
                finish: 5}
end
