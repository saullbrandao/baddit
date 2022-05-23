class RemoveUpAndDownVotesFromPostsAndComments < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :upvotes
    remove_column :posts, :downvotes
    remove_column :comments, :upvote
    remove_column :comments, :downvote
  end
end
