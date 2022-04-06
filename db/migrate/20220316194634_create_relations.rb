# frozen_string_literal: true

class CreateRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :relations do |t|
      t.references :follower,  foreign_key: { to_table: :users }
      t.references :followee,  foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
