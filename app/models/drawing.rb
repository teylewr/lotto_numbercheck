class Drawing < ActiveRecord::Base
    validates_presence_of :pick_one, :pick_two, :pick_three, :pick_four, :pick_five, :bonus_one, :game_id

    searchkick

    POWERBALL_DRAWS = 5 #number of regular numbers drawn 

    #only indexing first five numbers for now
    def search_data
        {
          pick_one: pick_one,
          pick_two: pick_two,
          pick_three: pick_three,
          pick_four: pick_four,
          pick_five: pick_five,
          bonus_one: bonus_one
        }
    end

    def self.find_by_game_nums_and_bonus(game_id,nums,bonus)
        Drawing.where(game_id:game_id).search('*',
                        where: { 
                            or: [
                                    [
                                        {pick_one: nums},
                                        {pick_two: nums},
                                        {pick_three: nums},
                                        {pick_four: nums},
                                        {pick_five: nums},
                                        {bonus_one:bonus}
                                    ]
                                ]
                        }).results
    end

    def matches_count(user_nums)
        POWERBALL_DRAWS - (number_array - user_nums).size
    end

    def has_bonus_match(bonus_number)
        bonus_one == bonus_number
    end

    def number_array
        return [pick_one, pick_two, pick_three, pick_four, pick_five]
    end

end
