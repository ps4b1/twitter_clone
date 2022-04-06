# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :set_message, only: [:destroy]
  def create
    @message = Message.new(message_params)
    @message.chatroom_id = @chatroom.id
    @message.user = current_user
    if @message.save
      redirect_to current_chatroom
    else
      flash[:alert] = 'something went wrong'
    end
  end

  def destroy
  end

  private

  def message_params
    params.require(:message).permit(:chatroom_id, :content)
  end

  def set_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end

  def set_message
    @message = Message.find(params[:id])
  end
end
