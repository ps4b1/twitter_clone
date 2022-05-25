# frozen_string_literal: true

class ChatroomUsersController < ApplicationController
  include CurrentChatroom

  def destroy
    current_chatroom = Chatroom.find(params[:chatroom])
    @chatroom_user = ChatroomUser.find_by(chatroom_id: params[:chatroom], user_id: params[:user])
    admin = @chatroom_user.admin
    @chatroom_user.destroy
    current_chatroom.destroy if current_chatroom.users.count == 0

    if params[:user] == current_user.id.to_s
      redirect_to chatrooms_path
    end

    if admin && current_chatroom.users.count > 0
      next_user = current_chatroom.chatroom_users.first
      next_user.update(admin: true)
    end
  end
end
