class CreateLeadtimes < ActiveRecord::Migration[5.2]
  def change
    create_table :leadtimes do |t|
      t.string :leadtime, null:false

      t.timestamps
    end
  end
end
