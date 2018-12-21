class CreatePostageSelectsShippings < ActiveRecord::Migration[5.2]
  def change
    create_table :postage_selects_shippings do |t|
      t.references :postage_select, null: false
      t.references :shipping, null: false

      t.timestamps
    end
  end
end
