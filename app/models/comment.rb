# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :description, presence: true, length: { maximum: 230 }
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :likes, as: :likeable
  has_many :posts, as: :repostable
  has_many :comments, as: :commentable, dependent: :destroy

  def count_likes
    likes.count
  end
end
