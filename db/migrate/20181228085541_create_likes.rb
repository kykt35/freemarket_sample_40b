class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, null:false, foreign_key: true
      t.references :item, null:false, foreign_key: true

      t.timestamps

      t.index [:user_id, :item_id], unique: true
    end
  end
end
