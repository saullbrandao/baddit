require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:one)
    @community = @post.community
  end

  test "should get index" do
    get root_path
    assert_response :success
    assert_select "h1", "Posts"
  end

  test "should get show" do
    get community_post_path(@community.slug, @post.slug)
    assert_response :success
    assert_select "h1", posts(:one).title
    assert_select "p", posts(:one).body
  end 

  test "should get new only if logged in" do
    get new_post_path
    assert_response :redirect
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
    
    sign_in users(:one)
    get new_post_path
    assert_select "h1", "New Post"
    assert_select "button", "Create Post"
  end

  test "should create post" do
    sign_in users(:one)

    assert_difference "Post.count", 1 do
      post posts_path, params: { post: { title: "Test Post",
                                         body: "Test Body",
                                         community: communities(:one).name } }
    end

    assert_redirected_to community_post_path(@community.slug, Post.last.slug)
    assert_equal "Post created successfully!", flash[:success]
  end
  
  test "should not create post if not logged in" do
    assert_difference "Post.count", 0 do
      post posts_path, params: { post: { title: "Test Post",
                                         body: "Test Body",
                                         community: communities(:one).name } }
    end

    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  test "should not create post if not joined the community" do
    sign_in users(:two)

    assert_difference "Post.count", 0 do
      post posts_path, params: { post: { title: "Test Post",
                                         body: "Test Body",
                                         community: communities(:one).name } }
    end

    assert_redirected_to root_path
    assert_equal "You need to join the community before creating a post!", flash[:error]
  end

  test "should get edit only if owns the post" do
    sign_in users(:two)
    get edit_post_path(@post)
    assert_response :redirect
    assert_equal "You are not allowed to do this action!", flash[:error]
    assert_redirected_to :root

    sign_in users(:one)
    get edit_post_path(@post)
    assert_select "h1", "Edit Post"
    assert_select "button", "Update Post"
  end

  test "should update post" do
    sign_in users(:one)

    patch post_path(@post), params: { post: { title: "Test Post",
                                              body: "Test Body" }}
    assert_redirected_to community_post_path(@community.slug, @post.slug)
    assert_equal "Post updated successfully!", flash[:success]
    assert_equal "Test Post", @post.reload.title
    assert_equal "Test Body", @post.reload.body
  end

  test "should not update post if not logged in" do
    patch post_path(@post), params: { post: { title: "Test Post",
                                              body: "Test Body" }}
    assert_response :redirect
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  test "should destroy post only if has ownership" do
    sign_in users(:two)
    assert_difference "Post.count", 0 do
      delete post_path(@post)
    end

    assert_redirected_to root_path
    assert_equal "You are not allowed to do this action!", flash[:error]

    sign_in users(:one)
    assert_difference "Post.count", -1 do
      delete post_path(@post)
    end
    assert_redirected_to root_path
    assert_equal "Post deleted successfully!", flash[:success]
  end

  test "should upvote post" do
    sign_in users(:one)
    assert_difference "Post.find(#{@post.id}).votes.count", 1 do
      patch post_upvote_path(@post.id)
    end
    assert_equal 1, @post.votes.first.vote
  end

  test "should dowvote post" do
    sign_in users(:one)
    assert_difference "Post.find(#{@post.id}).votes.count", 1 do
      patch post_downvote_path(@post.id)
    end
    assert_equal -1, @post.votes.first.vote
  end

  test "should not upvote or downvote post if not logged in" do
    assert_difference "Post.find(#{@post.id}).votes.count", 0 do
      patch post_upvote_path(@post.id)
    end
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]

    assert_difference "Post.find(#{@post.id}).votes.count", 0 do
      patch post_downvote_path(@post.id)
    end
  end
end
