# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :require_same_user, only: %i[edit update destroy]

  # GET /posts or /posts.json
  def index
    @posts = Post.all.order(:created_at).reverse
  end

  # GET /posts/1 or /posts/1.json
  def show; end

  # GET /posts/group.html.erb
  def new
    @post = Post.new
    if params[:repostable_id].present? && params[:repostable_type].present?
      @repostable_id = params[:repostable_id]
      @repostable_type = params[:repostable_type]
    else
      @repostable_id = nil
      @repostable_type = nil
    end
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @user = @post.user
    @post.destroy

    respond_to do |format|
      format.html { redirect_to profile_path(@user), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:content, :photo, :repostable_id, :repostable_type)
  end

  def require_same_user
    redirect_to posts_url, alert: 'You can edit and delete only your posts' if current_user != @post.user
  end
end
