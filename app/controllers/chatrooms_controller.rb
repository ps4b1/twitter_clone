# frozen_string_literal: true

class ChatroomsController < ApplicationController
  def create
    if (direct_chat = direct_chat(chatroom_params))
      return redirect_to direct_chat
    end

    chatroom = Chatroom.new(chatroom_params)

    if chatroom.save
      redirect_to chatroom_path(chatroom)
    else
      flash[alert] = 'Something went wrong'
      redirect_to root_path
    end
  end

  def group
    @chatroom = Chatroom.new
    # (room_name: 'New group')
    # @chatroom.save
    @users = User.where.not(id: current_user.id)
    # chatroom_users = ChatroomUser.new(user: current_user, chatroom: @chatroom)
    # chatroom_users.save
  end

  def destroy
    @chatroom = Chatroom.find(params[:id])
    @chatroom.destroy
    redirect_to chatrooms_path
  end

  def index
    @chatrooms = current_user.chatrooms
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = @chatroom.messages.order(:created_at)
  end

  private

  def direct_chat(attr)
    return unless attr[:direct]

    other = User.find(attr[:chatroom_users_attributes]['0'][:user_id])
    chatroom = Chatroom.find_direct(current_user, other)

    chatroom_path(chatroom) if chatroom
  end

  def chatroom_params
    params.require(:chatroom).permit(:direct, chatroom_users_attributes: [:user_id])
  end
end
