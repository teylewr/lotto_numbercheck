require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

  test "should get index" do
    get :home
    assert_response :success
  end

end
