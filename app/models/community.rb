class Community < ApplicationRecord
  before_create :add_slug

  has_many :posts, dependent: :destroy
  has_many :community_users, dependent: :destroy
  has_many :users, through: :community_users
  belongs_to :owner, class_name: "User"

  validates :name, presence: true, length: { minimum: 3, maximum: 20 }, uniqueness: true
  validates :slug, uniqueness: true

  private
  
  def add_slug
    self.slug = name.delete(' ')
  end
end
