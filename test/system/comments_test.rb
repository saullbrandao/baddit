require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
    @comment = comments(:one)
    login_as users(:one)
  end

  test "creating a Comment" do
    visit community_post_url(@post.community.slug, @post.slug)

    fill_in "Body", with: "Test Comment"
    click_on "Create Comment"

    assert_text "Comment created successfully!"
  end

  test "updating a Comment" do
    visit community_post_url(@post.community.slug, @post.slug)

    click_on "Edit Comment"

    fill_in "Body", with: "Updated Test Comment"
    click_on "Update Comment"

    assert_text "Comment updated successfully!"
  end

  test "upvote a Comment" do
    visit community_post_url(@post.community.slug, @post.slug)

    assert_text "Vote"
    click_on "Upvote Comment"
    assert_text "1"
  end

  test "downvote a Comment" do
    visit community_post_url(@post.community.slug, @post.slug)

    assert_text "Vote"
    click_on "Downvote Comment"
    assert_text "-1"
  end

  test "destroying a Comment" do
    visit community_post_url(@post.community.slug, @post.slug)

    page.accept_confirm do
      click_on "Destroy Comment", match: :first
    end

    assert_text "Comment deleted successfully!"
  end
end
