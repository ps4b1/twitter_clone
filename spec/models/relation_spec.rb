# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relation, type: :model do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @relation = Relation.new(follower_id: @user1.id, followee_id: @user2.id)
  end
  it 'should be valid' do
    expect(@relation).to be_valid
  end
  it 'should not be valid without follower' do
    @relation.follower_id = nil
    expect(@relation).not_to be_valid
  end
  it 'should not be valid without followee' do
    @relation.followee_id = nil
    expect(@relation).not_to be_valid
  end
  it 'should have unique follower/followee relation' do
    @relation_test = Relation.create(follower_id: @user1.id, followee_id: @user2.id)
    expect(@relation).not_to be_valid
  end
end
