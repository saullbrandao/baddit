require "test_helper"

class CommunityTest < ActiveSupport::TestCase
  def setup
    @community = communities(:one)
  end

  test "should be valid" do
    assert @community.valid?
  end

  test "name should be present" do
    @community.name = ""
    assert_not @community.valid?
  end

  test "name should be between 3 and 50 characters" do
    @community.name = "a" * 2
    assert_not @community.valid?

    @community.name = "a" * 51
    assert_not @community.valid?
  end

  test "slug should be unique" do
    @community.slug = communities(:two).slug
    assert_not @community.valid?
  end
end
