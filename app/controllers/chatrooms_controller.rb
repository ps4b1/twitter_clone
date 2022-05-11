# frozen_string_literal: true

class ChatroomsController < ApplicationController
  def create
    @chatroom = Chatroom.new(chatroom_params)

    respond_to do |format|
      if @chatroom.valid?
        if @chatroom.direct
          chatroom = Chatroom.find_direct(current_user, User.find(params[:user_ids].first))
          return redirect_to(chatroom_path(chatroom)) if chatroom.present?
        end

        ChatroomUser.create!(chatroom: @chatroom, user: current_user)
        @chatroom.save

        format.html do
          redirect_to chatroom_path(@chatroom)
        end
        format.json { render :show, status: :created, location: @chatroom }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end

  def group
    @chatroom = Chatroom.new
    @users = User.where.not(id: current_user.id)
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
    params.require(:chatroom).permit(:room_name, :direct, user_ids: [])
  end
end
