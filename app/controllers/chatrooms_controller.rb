# frozen_string_literal: true

class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: %i[show edit update destroy]

  def create
    @chatroom = Chatroom.new(chatroom_params)

    respond_to do |format|
      if @chatroom.valid?
        if @chatroom.direct
          chatroom = Chatroom.find_direct(current_user, User.find(params[:user_ids].first))
          return redirect_to(chatroom_path(chatroom)) if chatroom.present?
        end

        ChatroomUser.create!(chatroom: @chatroom, user: current_user, admin: true)
        @chatroom.save

        format.html do
          redirect_to chatroom_path(@chatroom)
        end
        format.json { render :show, status: :created, location: @chatroom }
      else
        format.html { redirect_to :group, alert: 'Need to add group name or select participantes' }
        format.json { render json: @chatroom.errors }
      end
    end
  end

  def group
    @chatroom = Chatroom.new
    @users = User.where.not(id: current_user.id)
  end

  def destroy
    @chatroom.destroy
    redirect_to chatrooms_path
  end

  def index
    @chatrooms = current_user.chatrooms
  end

  def show
    @message = @chatroom.messages.order(:created_at)
  end

  def edit
    if @chatroom.direct
      redirect_to chatroom_path(@chatroom)
      flash[:alert] = "Can't edit direct message"
    end
    @users = @chatroom.users.all.where.not(id: current_user.id)
  end

  def update
    if @chatroom.direct
      redirect_to chatroom_path(@chatroom)
      flash[:alert] = "Can't edit direct message"
    end
    respond_to do |format|
      if @chatroom.update(chatroom_params)
        format.html do
          redirect_to edit_chatroom_path(@chatroom),
                      notice: "Chatroom was successfully updated to #{@chatroom.room_name}."
        end
        format.json { render :show, status: :ok, location: @chatroom }
      else
        format.html { render :edit, alert: 'something went wrong' }
        format.json { render json: @chatroom.errors }
      end
    end
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end

  def direct_chat(attr)
    return unless attr[:direct]

    other = User.find(attr[:chatroom_users_attributes]['0'][:user_id])
    chatroom = Chatroom.find_direct(current_user, other)

    chatroom_path(chatroom) if chatroom
  end

  def chatroom_params
    if params[:chatroom]
      params.require(:chatroom).permit(:room_name, :direct, user_ids: [])
    else
      params.permit(:room_name, :direct, user_ids: [])
    end
  end
end
