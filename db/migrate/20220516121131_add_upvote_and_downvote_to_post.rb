class AddUpvoteAndDownvoteToPost < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :votes, :total_votes
    add_column :posts, :upvotes, :integer, :default => 0
    add_column :posts, :downvotes, :integer, :default => 0
  end
end
