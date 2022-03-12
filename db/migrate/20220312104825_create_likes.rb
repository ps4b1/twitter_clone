# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :likeable_id, null: false, foreign_key: true
      t.string :likeable_type

      t.timestamps
    end

    add_index :likes, %i[user_id likeable_id likeable_type], unique: true
    add_index :likes, %i[likeable_id likeable_type]
  end
end
