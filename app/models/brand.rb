class Brand < ApplicationRecord
  has_many :brands_categories
  has_many :categories, through: :brands_categories

  def self.item_search(params,items)
    brands = params[:brand]
    if brands.present?
      items = items.where(brand: brands)
    end
    return items, brands
  end
end
