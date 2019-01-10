class CreateSalesAmounts < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_amounts do |t|
      t.references :user, null:false, foreign_key: true
      t.integer :price, null:false
      t.datetime  :limit_date, null:false
      t.timestamps
    end
  end
end
