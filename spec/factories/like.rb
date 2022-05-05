# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    user_id { 1 }
    likeable_id { 1 }
    likeable_type { 'Post' }
  end
end
