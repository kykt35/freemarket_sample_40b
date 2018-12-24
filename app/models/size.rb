class Size < ApplicationRecord
  has_many :items
  has_many :categories_sizes, dependent: :destroy
  has_many :categories, through: :categories_sizes
end
