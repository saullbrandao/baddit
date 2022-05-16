class Post < ApplicationRecord
  include ActionView::Helpers::TextHelper
  belongs_to :community

  before_create :add_slug, :add_total_votes

  validates :title, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: { scope: :community_id }
  validates :body, presence: true, length: { minimum: 3, maximum: 500 }
  validates :slug, uniqueness: { scope: :community_id }
  
  def votes_difference
    self.upvotes - self.downvotes
  end

  private
  
  def add_slug
    self.slug = title.parameterize.underscore
  end
  
  def add_total_votes
    self.total_votes = upvotes + downvotes
  end

end
