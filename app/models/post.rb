# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  validates :description, presence: true, length: {maximum: 150}

end
