# frozen_string_literal: true

class AddAdminToChatroomUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :chatroom_users, :admin, :boolean, default: false
  end
end
