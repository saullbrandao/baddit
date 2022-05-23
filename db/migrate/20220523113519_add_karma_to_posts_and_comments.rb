class AddKarmaToPostsAndComments < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :karma, :integer, default: 0
    add_column :comments, :karma, :integer, default: 0
    add_column :comments, :total_votes, :integer, default: 0
  end
end
