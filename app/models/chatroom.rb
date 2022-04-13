# frozen_string_literal: true

class Chatroom < ApplicationRecord
  has_many :messages
  has_many :chatroom_users
  has_many :users, through: :chatroom_users
  accepts_nested_attributes_for :chatroom_users

  scope :direct, -> { where(direct: true) }

  def last_message
    messages.order(:created_at).last
  end

  def self.find_direct(user, other)
    user.chatrooms.direct.each do |chat|
      return chat if chat.users.include? other
    end

    nil
  end
end
