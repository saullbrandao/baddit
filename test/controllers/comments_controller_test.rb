require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @comment = comments(:one)
  end

  test "should delete comment" do
    assert_difference("Comment.count", -1) do
      delete comment_path(@comment)
    end

    assert_redirected_to posts_path(slug: @comment.post.slug)
  end
end
