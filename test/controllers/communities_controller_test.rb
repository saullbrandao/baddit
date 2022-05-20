require "test_helper"

class CommunitiesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @community = communities(:one)
  end
  
  test "should get show" do
    get community_path(@community.slug)
    assert_response :success
    assert_select "h1", @community.name
  end
  
  test "should get new only if logged in" do
    get new_community_path
    assert_response :redirect
    assert_redirected_to new_user_session_path

    sign_in users(:one)
    get new_community_path
    assert_response :success
    assert_select "h1", "New Community"
  end

  test "should destroy community only if has ownership" do
    sign_in users(:two)
    assert_difference "Community.count", 0 do
      delete community_path(@community.slug)
    end
    
    sign_in users(:one)
    assert_difference "Community.count", -1 do
      delete community_path(@community.slug)
    end
  end
end
