class Leadtime < ApplicationRecord
  has_many :items
  validates :text, presence: true
end
