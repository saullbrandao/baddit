require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get posts_url
    assert_response :success
    assert_select "h1", "Posts"
    assert_select "h2", "Post 1"
  end
end
