# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)
    if !@like.save
      redirect_to root_path
      flash[:alert] = 'Something went wrong'
    else
      redirect_to root_path
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    likeable = @like.likeable
    @like.destroy
    redirect_to root_path
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
