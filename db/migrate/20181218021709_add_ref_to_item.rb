class AddRefToItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :seller, foreign_key: { to_table: :users }
    add_reference :items, :category, foreign_key: true, null:false
    add_reference :items, :brand, foreign_key: true
    add_reference :items, :size, foreign_key: true
    add_reference :items, :item_condition, foreign_key: true, null:false
    add_reference :items, :shipping, foreign_key: true, null:false
    add_reference :items, :postage_select, foreign_key: true, null:false
    add_reference :items, :prefecture, foreign_key: true, null:false
    add_reference :items, :leadtime, foreign_key: true, null:false
  end
end
