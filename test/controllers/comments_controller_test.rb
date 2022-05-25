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

  test "should upvote comment" do
    sign_in users(:one)
    assert_difference "Comment.find(#{@comment.id}).votes.count", 1 do
      patch comment_upvote_path(@comment)
    end
    assert_equal 1, @comment.votes.first.vote
  end

  test "should dowvote comment" do
    sign_in users(:one)
    assert_difference "Comment.find(#{@comment.id}).votes.count", 1 do
      patch comment_downvote_path(@comment)
    end
    assert_equal -1, @comment.votes.first.vote
  end

  test "should not upvote or downvote comment if not logged in" do
    assert_difference "Comment.find(#{@comment.id}).votes.count", 0 do
      patch comment_upvote_path(@comment)
    end

    assert_difference "Comment.find(#{@comment.id}).votes.count", 0 do
      patch comment_downvote_path(@comment)
    end
  end
end
