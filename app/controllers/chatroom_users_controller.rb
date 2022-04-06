class ChatroomUsersController < ApplicationController
  include CurrentChatroom
  before_action :create_chatroom, only: [:create]
  def create
  end

  def destroy
  end
end
