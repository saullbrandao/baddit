class Post < ApplicationRecord
  include ActionView::Helpers::TextHelper
  before_create :add_slug

  has_many :comments, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  belongs_to :community
  belongs_to :user

  validates :title, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: { scope: :community_id }
  validates :body, presence: true, length: { minimum: 3, maximum: 500 }
  validates :slug, uniqueness: { scope: :community_id }
  
  private
  
  def add_slug
    self.slug = title.parameterize.underscore
  end
end
