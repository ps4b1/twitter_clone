# frozen_string_literal: true

class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :chatroom_users, dependent: :delete_all
  has_many :users, through: :chatroom_users

  def last_message
    messages.order(:created_at).last
  end

end
