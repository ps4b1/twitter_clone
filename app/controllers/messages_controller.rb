# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :set_message, only: [:destroy]
  def create
    @message = Message.new(message_params)
    @chatroom = @message.chatroom
    if @message.save
      # redirect_to @message.chatroom
      ActionCable.server.broadcast 'chatroom', html: render_to_string('chatrooms/_chatroom_messages', layout: false)
    else
      flash[:alert] = 'something went wrong'
    end
  end

  def destroy
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :chatroom_id, :content)
  end

  def set_message
    @message = Message.find(params[:id])
  end
end
