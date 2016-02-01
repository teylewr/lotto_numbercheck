require 'test_helper'

class GameTest < ActiveSupport::TestCase
    test "should not save drawing without a name" do
      game = Game.create({slug:'powerball'})
      assert_not game.save
    end

    test "should not save drawing without a slug" do
      game = Game.create({name:'powerball'})
      assert_not game.save
    end

    test "should not save if already exists" do
      game = Game.create({name:'powerball',slug:'powerball'})
      game2 = Game.create({name:'powerball',slug:'powerball'})
      assert_not game2.save
    end
end
