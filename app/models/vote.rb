class Vote < ApplicationRecord
  after_save :update_total_votes, :update_karma

  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :user_id, uniqueness: { scope: [:votable_id, :votable_type] }
  validates :vote, inclusion: { in: [-1, 1] }

  def self.upvote(user, votable)
    vote = Vote.find_or_initialize_by(user: user, votable: votable)

    if vote.vote == 1
      vote.destroy
    else
      vote.vote = 1
      vote.save
    end
  end

  def self.downvote(user, votable)
    vote = Vote.find_or_initialize_by(user: user, votable: votable)

    if vote.vote == -1
      vote.destroy
    else
      vote.vote = -1
      vote.save
    end
  end

  private

  def update_total_votes
    self.votable.total_votes = self.votable.votes.count
    self.votable.save
  end
  
  def update_karma
    self.votable.karma = self.votable.votes.sum(:vote)
    self.votable.save
  end
end
