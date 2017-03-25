class AddDescriptionToTrackers < ActiveRecord::Migration[5.0]
  def change
    add_column :trackers, :direction, :float
  end
end
