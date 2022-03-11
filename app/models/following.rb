# frozen_string_literal: true

class Following < ApplicationRecord
  belongs_to :user
  belongs_to :subscribed, class_name: 'User'
end
