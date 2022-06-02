# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:id) {|n| n}
    sequence(:username) { |n| "User+#{n}" }
    sequence(:email) { |n| "user+#{n}@example.com" }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
