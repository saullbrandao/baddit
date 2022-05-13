class CreateCommunities < ActiveRecord::Migration[7.0]
  def change
    create_table :communities do |t|
      t.string :name, null: false, unique: true
      t.string :slug, null: false, unique: true, index: true

      t.timestamps
    end

    add_reference :posts, :community
  end
end
