# frozen_string_literal: true

class ChatroomUsersController < ApplicationController
  include CurrentChatroom

  def destroy
    current_chatroom = Chatroom.find(params[:chatroom])
    chatroom_user = ChatroomUser.find_by(chatroom_id: params[:chatroom], user_id: params[:user])
    if chatroom_user.admin && current_chatroom.users.count.positive?
      next_user = current_chatroom.chatroom_users.first
      next_user.update(admin: true)
    end
    admin = chatroom_user.admin
    chatroom_user.destroy
    redirect_to chatrooms_path if params[:user] == current_user.id.to_s
    redirect_to edit_chatroom_path(current_chatroom) if !admin && current_chatroom.users.count.positive?
    current_chatroom.destroy if current_chatroom.users.count.zero?
  end
end
