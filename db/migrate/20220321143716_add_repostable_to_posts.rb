class AddRepostableToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :repostable_id, :integer,  foreign_key: true
    add_column :posts, :repostable_type, :string

    rename_column :posts, :description, :content
  end
end
