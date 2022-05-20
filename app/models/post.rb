class Post < ApplicationRecord
  include ActionView::Helpers::TextHelper
  before_create :add_slug, :add_total_votes

  has_many :comments, dependent: :destroy
  belongs_to :community
  belongs_to :user

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
