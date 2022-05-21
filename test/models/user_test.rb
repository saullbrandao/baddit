require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = ""
    assert_not @user.valid?
  end

  test "username should be unique" do
    @user.username = users(:two).username
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "email should be unique" do
    @user.email = users(:two).email
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = ""
    assert_not @user.valid?
  end

  test "password should be at least 6 characters" do
    @user.password = "a" * 5
    assert_not @user.valid?
  end

  test "should join community" do
    @user.join(communities(:two))
    assert_equal 1, @user.communities.count
  end

  test "should leave community" do
    @user.join(communities(:two))
    assert_equal 1, @user.communities.count

    @user.leave(communities(:two))
    assert_equal 0, @user.communities.count
  end

  test "should not join community if already joined" do
    @user.join(communities(:two))
    assert_equal 1, @user.communities.count

    @user.join(communities(:two))
    assert_equal 1, @user.communities.count
  end

  test "should not leave community if not joined" do
    @user.leave(communities(:two))
    assert_equal 0, @user.communities.count
  end

  test "should not join or leave a community if owns" do
    @user.join(communities(:one))
    assert_equal 0, @user.communities.count

    @user.leave(communities(:one))
    assert_equal 0, @user.communities.count
  end

  test "should return true if joined and false if not" do
    @user.join(communities(:two))
    assert_equal true, @user.joined?(communities(:two))
    assert_equal false, @user.joined?(communities(:three))
  end
end
