require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:one)
    @community = @post.community
  end

  test "should get index" do
    get root_path
    assert_response :success
    assert_select "h1", "Posts"
  end

  test "should get show" do
    get community_post_path(@community.slug, @post.slug)
    assert_response :success
    assert_select "h1", posts(:one).title
    assert_select "p", posts(:one).body
  end

  test "should get new" do
    get new_post_path
    assert_response :success
    assert_select "h1", "New Post"
    assert_select "form", 1
    assert_select "button", "Create Post"
  end
end
