# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :description
      t.references :commentable, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end