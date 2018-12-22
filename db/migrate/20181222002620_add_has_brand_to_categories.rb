class AddHasBrandToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :hasBrand, :bool, default: false
  end
end
