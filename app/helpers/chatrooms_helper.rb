# frozen_string_literal: true

module ChatroomsHelper
  def admin(user, chatroom)
    chatroom.chatroom_users.find_by(user_id: user.id).admin
  end
end
