# frozen_string_literal: true

class ChatroomsController < ApplicationController
  def create; end

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

  def chatroom_params
    params.fetch(:chatroom, {})
  end
end
