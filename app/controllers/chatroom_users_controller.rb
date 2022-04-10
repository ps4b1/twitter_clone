class ChatroomUsersController < ApplicationController
  include CurrentChatroom
  before_action :create_chatroom, only: [:create]
  def create
    @user=User.find(params[:user])
    @chatroom_users = ChatroomUser.new(user: @user, chatroom: @chatroom)
    @chatroom_current_user=ChatroomUser.new(user: current_user, chatroom: @chatroom)
    if @chatroom_users.save && @chatroom_current_user.save
      redirect_to chatroom_path(@chatroom)
    else
      flash[alert]="Something went wrong"
      redirect_to root_path
    end
  end

  def destroy
  end

  private

end
