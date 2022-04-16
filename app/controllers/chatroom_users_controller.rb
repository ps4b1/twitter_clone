class ChatroomUsersController < ApplicationController
  include CurrentChatroom
  before_action :create_chatroom, only: [:create]

  def create
    user=User.find(params[:user])
    chatroom = Chatroom.find(params[:chatroom])
    @chatroom_users = ChatroomUser.new(user: user, chatroom: chatroom)
    @chatroom_users.save
  end

  def destroy
  end

  private

end
