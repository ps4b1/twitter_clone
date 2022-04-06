# frozen_string_literal: true

class CreateChatroomUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :chatroom_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :chatroom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
