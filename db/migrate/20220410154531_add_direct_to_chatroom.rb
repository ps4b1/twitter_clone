# frozen_string_literal: true

class AddDirectToChatroom < ActiveRecord::Migration[6.1]
  def change
    add_column :chatrooms, :direct, :boolean, default: false
  end
end
