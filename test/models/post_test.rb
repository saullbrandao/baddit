require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @post = posts(:one)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "title should be present" do
    @post.title = ""
    assert_not @post.valid?
  end

  test "title should be between 3 and 50 characters" do
    @post.title = "a"
    assert_not @post.valid?

    @post.title = "a" * 10
    assert @post.valid?
    
    @post.title = "a" * 51
    assert_not @post.valid?
  end
  
  test "body should be present" do
    @post.body = ""
    assert_not @post.valid?
  end
  
  test "body should be between 3 and 500 characters" do
    @post.body = "a"
    assert_not @post.valid?
  
    @post.body = "a" * 100
    assert @post.valid?
    
    @post.body = "a" * 501
    assert_not @post.valid?
  end  
end
