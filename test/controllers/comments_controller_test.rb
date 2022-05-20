require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @comment = comments(:one)
  end

  test "should delete comment only if has ownership" do
    sign_in users(:two)
    assert_difference("Comment.count", 0) do
      delete comment_path(@comment)
    end

    assert_redirected_to root_path

    sign_in users(:one)
    assert_difference("Comment.count", -1) do
      delete comment_path(@comment)
    end

    assert_redirected_to posts_path(slug: @comment.post.slug)
  end
end
