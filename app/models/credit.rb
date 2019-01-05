class Credit < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
