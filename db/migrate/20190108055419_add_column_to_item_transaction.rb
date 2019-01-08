class AddColumnToItemTransaction < ActiveRecord::Migration[5.2]
  def change
     add_column :item_transactions, :point, :integer
  end
end
