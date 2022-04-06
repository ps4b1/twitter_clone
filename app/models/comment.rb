# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :description, presence: true, length: { maximum: 230 }
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :likes, as: :likeable
  has_many :posts, as: :repostable, dependent: :destroy
  has_many :replys, class_name: 'Comment', as: :commentable, dependent: :destroy

  def count_likes
    likes.count
  end
end
