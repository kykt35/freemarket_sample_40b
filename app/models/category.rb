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
        items_array << child.all_items
      end
    else
      items_array << items
    end
    return items_array.flatten
  end

  def self.item_search(params,items)
    search_l = params[:search_item_l_category_id]
    search_m = params[:search_item_m_category_id]
    search = params[:search_item_category_id]
    if search.present?
      items = items.where(category_id: search)
    elsif search_m.present?
      items = items.where(m_category_id: search_m)
    elsif search_l.present?
      items = items.where(l_category_id: search_l)
    end
    return items, search_l, search_m, search
  end

  def self.cache_all
    Rails.cache.fetch("categories"){Category.all}
  end
end
