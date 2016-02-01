module DrawingsHelper

    def get_prize_amount(args={})
        game_slug = args[:game_slug]
        matches = args[:matches_count]
        bonus_match = args[:bonus_match]

        case game_slug
            when 'powerball'
                get_powerball_prize(matches, bonus_match)
            when 'megamillions'
                get_megamillions_prize
            else
                0
        end

    end

    #prizes from 
    #http://www.powerball.com/powerball/pb_prizes.asp
    def get_powerball_prize(matches,bonus_match)
        case matches 
            when 0,1
                return 4 if bonus_match
                return 0
            when 2
                return 7 if bonus_match
                return 0
            when 3
                return 100 if bonus_match
                return 7
            when 4
                return 100 if bonus_match
                return 50000 
            when 5
                return "jackpot" if bonus_match
                return 10000000
            else 
                return "error"
        end

    end

    def get_megamillions_prize
        #TODO: Logic for megamillions when added
    end
end
