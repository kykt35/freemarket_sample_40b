class CreateItemPrices < ActiveRecord::Migration[5.2]
  def change
    create_table :item_prices do |t|
      t.text :price_tag
      t.integer :min_price
      t.integer :max_price
    end
  end
end
