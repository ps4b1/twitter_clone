# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :likes, as: :likeable
  has_many :comments, as: :commentable
  validates :description, presence: true, length: { maximum: 150 }

  def count_likes
    likes.count
  end

  def show_comments
    comments.all
  end

  def count_comments
    comments.count
  end
end
