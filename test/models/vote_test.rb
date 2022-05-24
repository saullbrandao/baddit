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
  
  test "should update total_votes" do
    post = posts(:one)
    user = users(:one)

    assert_difference "post.votes.count", 1 do
      post.votes.create!(vote: 1, user: users(:one), votable: post)
    end

    assert_equal 1, post.total_votes

    assert_difference "post.votes.count", 1 do
      post.votes.create!(vote: 1, user: users(:two), votable: post)
    end

    assert_equal 2, post.total_votes
  end

  test "should update karma" do
    comment = comments(:one)
    user = users(:one)

    assert_difference "comment.votes.count", 1 do
      comment.votes.create!(vote: 1, user: users(:one), votable: comment)
    end

    assert_equal 1, comment.karma

    assert_difference "comment.votes.count", 1 do
      comment.votes.create!(vote: 1, user: users(:two), votable: comment)
    end

    assert_equal 2, comment.karma
    
    assert_difference "comment.votes.count", 1 do
      comment.votes.create!(vote: -1, user: users(:three), votable: comment)
    end

    assert_equal 1, comment.karma
  end
end
