class AddSlugToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :slug, :string, index: true, unique: true
  end
end
