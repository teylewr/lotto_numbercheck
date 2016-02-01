require 'csv'
require 'nokogiri'
require 'open-uri'

Game.create({name:"Powerball",slug:"powerball"})

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

end