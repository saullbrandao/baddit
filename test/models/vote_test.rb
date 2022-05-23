require "test_helper"

class VoteTest < ActiveSupport::TestCase
  test "should be valid" do
    assert votes(:one).valid?
  end

  test "vote should be only 1 or -1" do
    vote = votes(:one)
    vote.vote = 0
    assert_not vote.valid?
  end

  test "user should only have one vote to a votable" do
    assert_difference "Vote.count", 0 do
      Vote.new(user: users(:one), votable: posts(:one), vote: 1)
    end
  end

  test "should upvote" do
    post = posts(:two)
    Vote.upvote(users(:one),post)

    assert_equal 1, post.votes.last.vote
  end
  
  test "should downvote" do
    post = posts(:two)
    Vote.downvote(users(:one), post)

    assert_equal -1, post.votes.last.vote
  end
  
  test "should destroy vote if user tries to upvote an already upvoted post" do
    post = posts(:one)
    user = users(:one)

    assert_difference "post.votes.count", 1 do
      Vote.upvote(user, post)
    end    

    assert_difference "post.votes.count", -1 do
      Vote.upvote(user, post)
    end    
  end

  test "should destroy vote if user tries to downvote an already downvoted post" do
    post = posts(:one)
    user = users(:one)

    assert_difference "post.votes.count", 1 do
      Vote.downvote(user, post)
    end    
    
    assert_difference "post.votes.count", -1 do
      Vote.downvote(user, post)
    end    
  end
  
  test "should substitude vote if user tries to upvote an already downvoted post or vice versa" do
    post = posts(:one)
    user = users(:one)
    
    assert_difference "post.votes.count", 1 do
      Vote.downvote(user, post)
    end
    assert_equal -1, post.votes.last.vote
    
    assert_difference "post.votes.count", 0 do
      Vote.upvote(user, post)
    end
    assert_equal 1, post.votes.last.vote
    
    assert_difference "post.votes.count", 0 do
      Vote.downvote(user, post)
    end
    assert_equal -1, post.votes.last.vote
  end
end
