# frozen_string_literal: true

class CreateFollowers < ActiveRecord::Migration[6.1]
  def change
    create_table :followers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :subscriber, references: :users, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
