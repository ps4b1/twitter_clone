# frozen_string_literal: true

class RelationshipsController < ApplicationController
  def create
    potential = User.find(params[:relation])
    current_user.followings.build(subscribed_id: potential.id)
    potential.followers.build(subscriber_id: current_user.id)
    if current_user.save && potential.save
      redirect_to profile_path(potential)
      flash[:notice] = "You are following #{potential.username}"
    else
      flash[:alert] = 'Something went wrong!'
    end
  end

  def destroy
    potential = User.find(params[:id])
    follower=potential.followers.where(subscriber_id: current_user.id).first
    following = current_user.followings.where(subscribed_id: params[:id]).first
    following.destroy
    follower.destroy
    redirect_to profile_path(potential)
  end
end
