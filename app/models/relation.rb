# frozen_string_literal: true

class Relation < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'
  validates_uniqueness_of :followee_id, scope: %i[follower_id]
end
