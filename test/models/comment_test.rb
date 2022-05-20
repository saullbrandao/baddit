require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def setup
    @comment = comments(:one)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "body should be present" do
    @comment.body = ""
    assert_not @comment.valid?
  end

  test "body should be between 3 and 500 characters" do
    @comment.body = "a" * 2
    assert_not @comment.valid?

    @comment.body = "a" * 501
    assert_not @comment.valid?
  end

  test "should have a post" do
    @comment.post_id = nil
    assert_not @comment.valid?
  end
  
  test "should have a user" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end
end
