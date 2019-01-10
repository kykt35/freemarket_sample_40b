class ItemCondition < ApplicationRecord
  has_many :items
  validates :text, presence: true
  def self.item_search(params,items)
    item_condition_ids = params[:item_condition_id]
    if item_condition_ids.present?
      items = items.where(item_condition_id: item_condition_ids)
    end
    return items, item_condition_ids
  end
end
