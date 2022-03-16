# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: true
  validates :description, length: { maximum: 150 }
  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :followers, dependent: :destroy
  has_many :subscribers, through: :followers
  has_many :followings, dependent: :destroy
  has_many :subscribeds, through: :followings
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  after_commit :add_default_avatar, on: %i[create update]

  def avatar_thumbnail
    avatar.variant(resize: '150x150!').processed
  end

  def count_subscribers
    subscribers.count
  end

  def count_subscribed
    subscribeds.count
  end

  def not_following?(user)
    !followings.where(subscribed_id: user.id).exists?
  end

  private

  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default_avatar.png'
          )
        ), filename: 'default_avatar.png',
        content_type: 'image/png'
      )
    end
  end
end
