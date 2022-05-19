# frozen_string_literal: true

class ChatroomUsersController < ApplicationController
  include CurrentChatroom

  def destroy
    current_chatroom=Chatroom.find(params[:chatroom])
    @chatroom_user = ChatroomUser.find_by(chatroom_id: params[:chatroom], user_id: params[:user])
    @chatroom_user.destroy
    redirect_to chatrooms_path
    if current_chatroom.users.count == 0
      current_chatroom.destroy
    end
  end
end
