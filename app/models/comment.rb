class Comment < ApplicationRecord
  has_many :votes, as: :votable, dependent: :destroy
  belongs_to :post
  belongs_to :user

  validates :body, presence: true, length: { minimum: 3, maximum: 500 }
end
