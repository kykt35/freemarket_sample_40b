class RenameLikesToFavorite < ActiveRecord::Migration[5.2]
  def change
    rename_table :likes, :favorites
  end
end
