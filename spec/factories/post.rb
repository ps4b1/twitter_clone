# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    content  { 'test post' }
    user_id  { 1 }
  end
end
