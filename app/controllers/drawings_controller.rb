class DrawingsController < ApplicationController
    before_action :set_game, only: [:game_draws]

    #GET /checker
    #PARAMS: draw[:d1], draw[:2], draw[:d3], draw[:4], draw[:d5], b1
    #renders js
    def checker
        #TODO: when more games added pass in slug of what game is being checked 
        @game = Game.find_by_slug('powerball') 

        if !params[:draw].blank? && params[:draw].size == 5 && !params[:b1].blank?
            nums = params[:draw].map{|d| d[1].to_i}
            bonus = params[:b1].to_i

            #order by matches
            @result_array = get_result_array({nums: nums, bonus: bonus}).sort_by{ |r| r[:matches_count] }.reverse
        else   
            @result_array = {status: "error", message: "Not enough information given."}
        end

        respond_to do |format|
            format.js 
        end  

    end

    private

        #filters results to just records that pay out eg. 1 match with no bonus number typically doesnt pay
        #args: nums, bonus
        #returns hash of filtered results
        def get_result_array(args={})
            nums = args[:nums] 
            bonus = args[:bonus]

            get_relevant_drawings({nums: nums, bonus: bonus}).map do |d|                
            { 
                 :draw_date => d.draw_date.strftime('%a %b %d, %Y'), 
                 :pick_one => { :num => d.pick_one, :matched => is_matched?(d.pick_one,nums) }, 
                 :pick_two => { :num => d.pick_two, :matched => is_matched?(d.pick_two, nums) }, 
                 :pick_three => { :num => d.pick_three, :matched => is_matched?(d.pick_three, nums) }, 
                 :pick_four => { :num => d.pick_four, :matched => is_matched?(d.pick_four, nums) }, 
                 :pick_five => { :num => d.pick_five, :matched => is_matched?(d.pick_five, nums) }, 
                 :bonus_one => { :num => d.bonus_one, :matched => d.bonus_one == bonus }, 
                 :matches_count => d.matches_count(nums), 
                 :bonus_match =>  d.has_bonus_match(bonus)
             }
            end
        end

        def is_matched?(pick,nums)
            nums.include? pick
        end
        #get all the drawings that include the numbers to check
        #args: nums, bonus, matches_count, has_bonus_match
        def get_relevant_drawings(args={})
            nums = args[:nums]
            bonus = args[:bonus]
            
            drawings = Drawing.find_by_game_nums_and_bonus(@game.id,nums,bonus)

            #strip out records with no prize
            drawings.reject{|d| !has_prize({bonus_match: d.has_bonus_match(bonus),matches: d.matches_count(nums), game_slug: @game.slug })}
        end

        #game logic for prizes for specific games
        #args: matches, bonus_match, game_slug
        #returns true or false depending on game logic
        def has_prize(args={})
            matches = args[:matches] ||= 0
            bonus_match = args[:bonus_match] ||= false
            game_slug = args[:game_slug] ||= 'powerball'  #default to powerball if nothing passed in

            case game_slug
                when 'powerball'
                    #Powerball only pays if at least 3 matches or having powerball number
                    #http://www.powerball.com/powerball/pb_prizes.asp
                    return bonus_match || matches >= 3
                when 'megamillions'
                    #TODO: Megamillions logic when added
                    return false
                else
                    #TODO: default logic
                    return false
            end

        end

end
