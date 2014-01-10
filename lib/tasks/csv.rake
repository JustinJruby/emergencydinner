require 'csv'

namespace :csv do

  desc "Import CSV Data"
  task :import_stuff => :environment do

    csv_file_path = 'db/data.csv'

    CSV.foreach(csv_file_path) do |row|
      row = Recipe.create({
      	:title => row[0],
	:slug => row[1],
        :link => row[2],
        :source => row[3],
        :ingredient => row[4],
	:time => row[5],
	:time_note=> row[6],
	:tag_list =>row[7]
      })
      puts "Row added!"
    end
  end
end