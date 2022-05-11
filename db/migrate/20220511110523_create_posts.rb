class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false, min: 3, max: 50
      t.text :body, null: false, min: 3, max: 500
      t.integer :votes, default: 0

      t.timestamps
    end
  end
end
