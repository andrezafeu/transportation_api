namespace :tracker do
  desc "Add tracker data from csv file to db. Usage: tracker:import_data[bustracker.csv] to import a csv file called bustracker.csv"
  task :import_data, [:file_name] => [:environment] do |t, args|

    require 'csv'
    previous_lat, previous_lng = 0, 0
    CSV.foreach(args[:file_name], :headers => true) do |row|
      if (25-row["lat"].to_f).abs < 5 && (-80-row["lng"].to_f).abs < 5
        row["direction"] = set_row_direction(row, previous_lat, previous_lng) if previous_lat != 0
        Tracker.create!(row.to_hash)
        previous_lat, previous_lng = update_previous_lat(row), update_previous_lgn(row)
      end
    end
  end

  def set_row_direction(row, previous_lat, previous_lng)
    Math.atan2(row["lat"].to_f - previous_lat, row["lng"].to_f - previous_lng)
  end

  def update_previous_lat(row)
    row["lat"].to_f
  end

  def update_previous_lgn(row)
    row["lng"].to_f
  end

end