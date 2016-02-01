require 'test_helper'

class DrawingTest < ActiveSupport::TestCase
    test "should not save drawing without all picks" do
      drawing = Drawing.create({bonus_one:1})
      assert_not drawing.save
    end

     test "should not save drawing without bonus" do
      drawing = Drawing.create({pick_one: 1, pick_two: 3, pick_three: 2,pick_four: 4, pick_five: 6})
      assert_not drawing.save
    end   
end
