# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content  { 'test comment' }
    user_id  { 1 }
  end
end
