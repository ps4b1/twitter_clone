# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to @comment.commentable
    else
      flash[:alert] = 'Something went wrong'
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    commentable = @comment.commentable
    @comment.destroy
    redirect_to commentable
  end

  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :description)
  end
end
# što je kreativnost
# što piksar radi da je org kreativna
# koja je uloga kreativnosti pojedinca za kreativnost org