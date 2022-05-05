# frozen_string_literal: true

module UsersHelper
  def chatroom_with_user?(user)
    user.chatrooms.each do |chatroom|
      chatroom.chatroom_users.each do |relation|
        return chatroom if relation.user == current_user
      end
    end
    nil
  end
end
