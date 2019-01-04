class Category < ApplicationRecord
  has_ancestry
  has_many :items
  has_many :categories_sizes, dependent: :destroy
  has_many :sizes, through: :categories_sizes
  validates :name, presence: true

  def all_items
    items_array = []
    if has_children?
      children.each do |child|
        items_array << child.items unless child.items.empty?
        items_array << child.all_items
      end
    else
      items_array << items
    end
    return items_array.flatten
  end

end
