class AddAbaterToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users,:avater,:text
    add_column :users,:introduction,:text
    add_column :users,:birthday,:date
  end
end
