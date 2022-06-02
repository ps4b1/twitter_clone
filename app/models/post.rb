# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  belongs_to :repostable, polymorphic: true, optional: true
  has_one_attached :photo
  has_many :likes, as: :likeable
  has_many :posts, as: :repostable, dependent: :destroy
  has_many :comments, as: :commentable
  validates :content, presence: true, length: { minimum: 2, maximum: 150 }, if: proc { |p| p.repostable.nil? }

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
