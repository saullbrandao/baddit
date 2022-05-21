class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :owned_communities, foreign_key: :owner_id, class_name: "Community"
  has_many :community_users, dependent: :destroy
  has_many :communities, through: :community_users

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }


  def join(community)
    communities << community unless communities.include?(community) || owns?(community)
  end

  def leave(community)
    communities.delete(community) unless owns?(community)
  end

  def joined?(community)
    communities.include?(community)
  end

  def owns?(community)
    community.owner == self
  end 
end
