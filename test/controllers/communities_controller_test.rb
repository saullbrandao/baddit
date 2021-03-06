require "test_helper"

class CommunitiesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @community = communities(:one)
  end
  
  test "should get show" do
    get community_path(@community.slug)
    assert_response :success
    assert_select "h1", @community.name
    assert_select "span", "#{@community.users.count + 1} members"
  end
  
  test "should get new only if logged in" do
    get new_community_path
    assert_response :redirect
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
    
    sign_in users(:one)
    get new_community_path
    assert_response :success
    assert_select "h1", "New Community"
  end

  test "should create community" do
    sign_in users(:one)
    
    assert_difference("Community.count", 1) do
      post communities_path, params: { community: { name: "Test Community" } }
    end
    
    assert_redirected_to community_path(Community.last.slug)
    assert_equal "Community created successfully!", flash[:success]
  end
  
  test "should not create community if not logged in" do
    assert_difference("Community.count", 0) do
      post communities_path, params: { community: { name: "Test Community" } }
    end
    
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  test "should destroy community only if has ownership" do
    sign_in users(:two)
    assert_difference "Community.count", 0 do
      delete community_path(@community.slug)
    end
    
    sign_in users(:one)
    assert_difference "Community.count", -1 do
      delete community_path(@community.slug)
    end

    assert_redirected_to root_path
    assert_equal "Community deleted successfully!", flash[:success]
  end

  test "should join community only if logged in" do
    post community_join_path(@community.slug)
    assert_response :redirect
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
    
    sign_in users(:one)
    post community_join_path(@community.slug)
    assert_response :redirect
    assert_redirected_to community_path(@community.slug)
    assert_equal "You have joined the community!", flash[:success]
  end
    
  test "should leave community only if logged in" do
    delete community_leave_path(@community.slug)
    assert_response :redirect
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]

    sign_in users(:one)
    delete community_leave_path(@community.slug)
    assert_response :redirect
    assert_redirected_to community_path(@community.slug)
    assert_equal "You have left the community!", flash[:success]
  end
end
