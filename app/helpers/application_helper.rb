# frozen_string_literal: true

module ApplicationHelper
  def find_like(object)
    current_user.likes.find_by(likeable: object)
  end

  def not_following?(user)
    Relation.exists?(follower_id: current_user.id, followee_id: user.id)
  end

  def id_pass(object)
    object.id
  end

  def new_like
    Like.new
  end

  def new_comment
    Comment.new
  end

  def new_message
    Message.new
  end
end
