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
end
