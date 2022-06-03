# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    redirect_to root_path
    if @comment.save
    else
      flash[:alert] = 'Something went wrong'
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    commentable = @comment.commentable
    @comment.destroy
    redirect_to root_path
  end

  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :description)
  end
end
