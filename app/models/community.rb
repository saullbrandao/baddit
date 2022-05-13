class Community < ApplicationRecord
  has_many :posts, dependent: :destroy

  before_create :add_slug

  validates :name, presence: true, length: { minimum: 3, maximum: 20 }, uniqueness: true
  validates :slug, uniqueness: true

  private

  def add_slug
    self.slug = name.delete(' ')
  end
end
