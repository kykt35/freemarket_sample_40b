class RenameNameToText < ActiveRecord::Migration[5.2]
  def change
    rename_column :shippings, :name, :text
    rename_column :postage_selects, :name, :text
    rename_column :item_conditions, :name, :text
    rename_column :leadtimes, :leadtime, :text
  end
end
