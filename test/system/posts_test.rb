require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
    @community = communities(:one)
    login_as users(:one)
  end

  test "creating a Post" do
    visit root_url
    click_button "Dropdown"
    click_link "New Post"
    fill_in "Body", with: "Test Post Body"
    fill_in "Title", with: "Test Post Title"
    select @community.name, :from => "post[community]"
    
    click_on "Create Post"
    assert_text "Post created successfully!"
  end

  test "updating a Post" do
    visit community_post_path(@post.community.slug, @post.slug)
    click_on "Edit Post"
    
    fill_in "Body", with: "Test Post Body"
    fill_in "Title", with: "Test Post Title"
    click_on "Update Post"
    
    assert_text "Post updated successfully!"
  end
  
  test "upvote a Post" do
    visit community_post_url(@post.community.slug, @post.slug)

    assert_text "Vote"
    click_on "Upvote Post"
    assert_text "1"
  end

  test "downvote a Post" do
    visit community_post_url(@post.community.slug, @post.slug)

    assert_text "Vote"
    click_on "Downvote Post"
    assert_text "-1"
  end

  test "destroying a Post" do
    visit community_post_path(@post.community.slug, @post.slug)
    page.accept_confirm do
      click_on "Destroy Post"
    end

    assert_text "Post deleted successfully!"
  end
end
