namespace :tracker do
  desc "Add tracker data from csv file to db. Usage: tracker:import_data[bustracker.csv] to import a csv file called bustracker.csv"
    task :import_data, [:file_name] => [:environment] do |t, args|

      require 'csv'    

      CSV.foreach(args[:file_name], :headers => true) do |row|
        Tracker.create!(row.to_hash)
      end

    end

end