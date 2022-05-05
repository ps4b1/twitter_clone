# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(:created_at).reverse
  end

  def index
    @users = User.all
  end
end
