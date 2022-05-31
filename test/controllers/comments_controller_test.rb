require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @comment = comments(:one)
  end
  
  test "should create comment" do
    @post = posts(:one)
    sign_in users(:one)

    assert_difference("Comment.count", 1) do
      post post_comments_path(@post), params: { body: @comment.body, user_id: @comment.user_id }
    end

    assert_redirected_to community_post_path(@post.community.slug, @post.slug)
    assert_equal "Comment created successfully!", flash[:success]
  end

  test "should not create comment if not logged in" do
    @post = posts(:one)

    assert_difference("Comment.count", 0) do
      post post_comments_path(@post), params: { body: @comment.body, user_id: @comment.user_id }
    end

    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
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
    assert_equal "Comment deleted successfully!", flash[:success]
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
