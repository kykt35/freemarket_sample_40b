class CreateItemTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :item_transactions do |t|
      t.references :user, foreign_key: true 
      t.references :item, foreign_key: true 
      t.timestamps
    end
  end
end
