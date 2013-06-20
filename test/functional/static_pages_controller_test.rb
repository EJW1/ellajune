require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get community_guidelines" do
    get :community_guidelines
    assert_response :success
  end

  test "should get welcome" do
    get :welcome
    assert_response :success
  end

  test "should get get_involved" do
    get :get_involved
    assert_response :success
  end

end
