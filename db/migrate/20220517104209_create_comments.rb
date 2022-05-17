class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :body, null: false
      t.integer :upvote, default: 0, numericality: { greater_than_or_equal_to: 0 }
      t.integer :downvote, default: 0, numericality: { greater_than_or_equal_to: 0 }

      t.timestamps
    end

    add_reference :comments, :post
    add_reference :comments, :parent_comment, foreign_key: { to_table: :comments } 
  end
end
