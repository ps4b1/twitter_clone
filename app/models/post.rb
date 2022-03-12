# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :likes, as: :likeable
  validates :description, presence: true, length: { maximum: 150 }

  def count_likes
    likes.count
  end
end
