class Size < ApplicationRecord
  has_many :items
  has_many :categories_sizes, dependent: :destroy
  has_many :categories, through: :categories_sizes

  def self.item_search(params,items)
    category_size = params[:category_size]
    size_ids = params[:size_id]
    category_sizes_ids = CategoriesSize.where(category_id: category_size).map{|cs| cs.size_id}
    if size_ids.present? && category_size.present?
      items = items.where(size_id: size_ids, m_category_id: category_size)
    elsif size_ids.blank? && category_size.present?
      category_size = ""
    end
    return items, category_size, size_ids, category_sizes_ids
  end
end
