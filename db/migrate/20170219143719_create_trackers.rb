class CreateTrackers < ActiveRecord::Migration[5.0]
  def change
    create_table :trackers do |t|
      t.datetime :time
      t.integer :vehicle_id
      t.float :lat
      t.float :lng
      t.float :speed

      t.timestamps
    end
  end
end
