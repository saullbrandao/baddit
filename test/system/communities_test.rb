require "application_system_test_case"

class CommunitiesTest < ApplicationSystemTestCase
  setup do
    @community = communities(:one)
    login_as users(:one)
  end

  test "creating a Community" do
    visit root_url
    click_button "Dropdown"
    click_link "Create Community"
    
    fill_in "Name", with: "Test Community"
    click_on "Create Community"

    assert_text "Community created successfully!"
  end

  test "joining a Community" do
    visit community_url(communities(:two).slug)

    click_on "Join"

    assert_text "You have joined the community!"
  end

  test "leaving a Community" do
    visit community_url(communities(:two).slug)

    click_on "Join"

    page.accept_confirm do
      click_on "Leave"
    end

    assert_text "You have left the community!"
  end

  test "destroying a Community" do
    visit community_url(@community.slug)

    page.accept_confirm do
      click_on "Delete"
    end

    assert_text "Community deleted successfully!"
  end
end
