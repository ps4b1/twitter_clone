# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user: @user)
    @like = Like.new(user: @user, likeable: @post)
  end
  it 'Should be valid' do
    expect(@like).to be_valid
  end
  it 'should not be valid without user' do
    @like.user = nil
    expect(@like).not_to be_valid
  end
  it 'should not be valid without likeable' do
    @like.likeable = nil
    expect(@like).not_to be_valid
  end
end
