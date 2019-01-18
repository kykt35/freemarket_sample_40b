class Brand < ApplicationRecord
  has_many :categories, through: :categories_sizes
  def self.item_search(params,items)
    brands = params[:brand]
    if brands.present?
      items = items.where(brand: brands)
    end
    return items, brands
  end
end
