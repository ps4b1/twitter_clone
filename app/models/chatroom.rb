class Chatroom < ApplicationRecord
  has_many :messages
  validates :room_name, presence: true
end
