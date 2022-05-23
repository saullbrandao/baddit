class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :vote, validates: { inclusion: { in: [-1, 1] } }
      t.references :votable, polymorphic: true   

      t.timestamps
    end
  end
end
