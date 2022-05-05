# frozen_string_literal: true

class ChatroomUsersController < ApplicationController
  include CurrentChatroom
  before_action :create_chatroom, only: [:create]

  def create
    user = User.find(params[:user])
    chatroom = Chatroom.find(params[:chatroom])
    @chatroom_users = ChatroomUser.new(user: user, chatroom: chatroom)
    @chatroom_users.save
  end

  def destroy
    @chatroom_user = ChatroomUser.find.where(chatroom_id: chatroom, user_id: user).first
    @chatroom_user.destroy
  end
end
