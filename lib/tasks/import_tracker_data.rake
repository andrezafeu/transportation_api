namespace :tracker do
  desc "Add tracker data from csv file to db. Usage: tracker:import_data[bustracker.csv] to import a csv file called bustracker.csv"
  task :import_data, [:file_name] => [:environment] do |t, args|

    require 'csv'
    previous_coord, previous_time = nil, nil
    
    CSV.foreach(args[:file_name], :headers => true) do |row|
      if previous_coord && previous_time

        base_lat = (25-row["lat"].to_f).abs < 5
        base_lgn = (-80-row["lng"].to_f).abs < 5

        if base_lat && base_lgn
          row["direction"] = set_row_direction(row, previous_coord)
          distance = calculate_distance(row, previous_coord)
          time_difference = calculate_time_difference(row["time"], previous_time)
          row["speed"] = calculate_speed(distance, time_difference)
          Tracker.create!(row.to_hash)
        end
      end
      previous_coord, previous_time = update_previous_coord(row["lat"], row["lng"]), update_previous_time(row["time"])
    end
  end

  def set_row_direction(row, previous_coord)
    Math.atan2(row["lat"].to_f - previous_coord[:lat], row["lng"].to_f - previous_coord[:lng])
  end

  def calculate_distance(row, previous_coord)
    rad_per_deg = Math::PI/180  # PI / 180
    rm = 6371 * 1000            # Earth radius in meters

    dlat_rad = (row["lat"].to_f-previous_coord[:lat]) * rad_per_deg  # Delta, converted to rad
    dlng_rad = (row["lng"].to_f-previous_coord[:lng]) * rad_per_deg

    lat1_rad, lng1_rad = previous_coord[:lat] * rad_per_deg, previous_coord[:lng] * rad_per_deg
    lat2_rad, lng2_rad = row["lat"].to_f * rad_per_deg, row["lng"].to_f * rad_per_deg

    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlng_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    rm * c # Delta in meters
  end

  def calculate_time_difference(time, previous_time)
    Time.parse(time) - previous_time
  end

  def calculate_speed(distance, time)
    distance/time * 2.23694 # convert meters/second in miles/hour
  end

  def update_previous_coord(lat, lng)
    {:lat => lat.to_f, :lng => lng.to_f}
  end

  def update_previous_time(time)
    Time.parse(time)
  end
end
