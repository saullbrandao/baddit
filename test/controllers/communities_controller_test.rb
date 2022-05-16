require "test_helper"

class CommunitiesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @community = communities(:one)
  end

  test "should get show" do
    get community_path(@community.slug)
    assert_response :success
    assert_select "h1", @community.name
  end

  test "should get new" do
    get new_community_path
    assert_response :success
    assert_select "h1", "New Community"
  end
end
