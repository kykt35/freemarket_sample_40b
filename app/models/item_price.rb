class ItemPrice < ApplicationRecord
  def self.item_search(params,items)
    min = params[:min_price]
    max = params[:max_price]
    if min.present?&&max.present?
      items = items.where('price >= ?', min).where('price <= ?', max)
    elsif min.present?&&max.blank?
      items = items.where('price >= ?', min)
    elsif min.blank?&&max.present?
      items = items.where('price <= ?', max)
    end
    return items, min, max
  end
end
