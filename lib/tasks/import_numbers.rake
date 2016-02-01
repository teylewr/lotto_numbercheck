require 'csv'
require 'nokogiri'
require 'open-uri'

namespace :get_results do

    task :powerball => :environment do
        count = 0

        open("#{Rails.root}/results/powerball.csv", 'wb') do |file|
            
            file << open('http://www.powerball.com/powerball/winnums-text.txt').read

            CSV.foreach(file, :headers => true) do |row|
                game = Game.find_by_slug("powerball") 
                data = row[0].split(" ")

                if !Drawing.find_by_draw_date_and_game_id(Date.strptime(data[0], "%m/%d/%Y") + 23.hours, game.id)
                    create_drawing(data,game.id)
                    count = count + 1
                end

            end
            Drawing.reindex
            p "#{count} drawings have been added."
            
        end
    end
end 

def create_drawing(data,game_id)
    Drawing.create(
        {
            game_id: game_id,
            pick_one: data[1],
            pick_two: data[2],
            pick_three: data[3],
            pick_four: data[4],
            pick_five: data[5],
            bonus_one: data[6],
            bonus_two: data[7],
            draw_date: Date.strptime(data[0], "%m/%d/%Y") + 23.hours
        }
    )
end
