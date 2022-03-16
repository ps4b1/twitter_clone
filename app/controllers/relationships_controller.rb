# frozen_string_literal: true

class RelationshipsController < ApplicationController
  def create
    potential = User.find(params[:relation])
    @relation = Relation.new(follower_id: current_user.id, followee_id: potential.id)
    if @relation.save
      redirect_to profile_path(potential)
      flash[:notice] = "You are following #{potential.username}"
    else
      flash[:alert] = 'Something went wrong!'
    end
  end

  def destroy
    @relation = Relation.find_by(follower_id: current_user.id, followee_id: params[:id])
    user = User.find(params[:id])
    @relation.destroy
    redirect_to profile_path(user)
  end
end
