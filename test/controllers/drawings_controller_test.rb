require 'test_helper'

class DrawingsControllerTest < ActionController::TestCase
    setup do
        Drawing.reindex
        Drawing.searchkick_index.refresh # don't forget this
        @drawing = drawings(:one)
    end

    test "should render js" do 
        get :checker, :draw=>{ :d1 => 1, :d2 => 2, :d3 => 3, :d4 => 4, :d5 => 5}, :b1 => 5, :format => 'js'
        response.content_type == Mime::JS
    end

    test "should set response array" do 
        get :checker, :draw=>{ :d1 => 1, :d2 => 2, :d3 => 3, :d4 => 4, :d5 => 5}, :b1 => 5, :format => 'js'
        !@response_array.nil?
    end


end
