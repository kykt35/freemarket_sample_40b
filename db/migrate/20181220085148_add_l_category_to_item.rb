class AddLCategoryToItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :l_category, foreign_key: { to_table: :categories }
    add_reference :items, :m_category, foreign_key: { to_table: :categories }
  end
end
