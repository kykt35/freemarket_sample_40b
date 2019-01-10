class PostageSelect < ApplicationRecord
  has_many :items
  has_many :postage_selects_shippings, dependent: :destroy
  has_many :shippings, through: :postage_selects_shippings
  validates :text, presence: true

  def self.item_search(params,items)
    postage_select_ids = params[:postage_select_id]
    if postage_select_ids.present?
      items = items.where(postage_select_id: postage_select_ids)
    end
    return items, postage_select_ids
  end
end
