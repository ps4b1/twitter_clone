# frozen_string_literal: true

class Chatroom < ApplicationRecord
  validates :room_name, presence: true, if: proc { |c| c.direct.nil? }
  has_many :messages, dependent: :destroy
  has_many :chatroom_users, dependent: :destroy
  has_many :users, through: :chatroom_users

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
