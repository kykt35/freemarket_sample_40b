class AddStatusToItemTransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :item_transactions, :status, :integer, default: 0
  end
end
