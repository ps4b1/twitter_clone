# frozen_string_literal: true

class ChatroomUser < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :chatroom, dependent: :destroy
end
