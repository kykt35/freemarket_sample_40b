class Category < ApplicationRecord
  has_ancestry
  has_many :items
  has_many :categories_sizes, dependent: :destroy
  has_many :sizes, through: :categories_sizes
end
