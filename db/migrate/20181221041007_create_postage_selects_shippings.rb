class CreatePostageSelectsShippings < ActiveRecord::Migration[5.2]
  def change
    create_table :postage_selects_shippings do |t|
      t.references :postage_select, null: false, foreign_key: true
      t.references :shipping, null: false, foreign_key: true

      t.timestamps
    end
  end
end
