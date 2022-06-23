# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user: @user)
    @comment = Comment.new(user: @user, commentable: @post, description: 'test comment')
  end
  it 'Should be valid' do
    expect(@comment).to be_valid
  end
  it 'should not be valid without user' do
    @comment.user = nil
    expect(@comment).not_to be_valid
  end
  it 'should not be valid without likeable' do
    @comment.commentable = nil
    expect(@comment).not_to be_valid
  end
  it 'should not be valid without content' do
    @comment.description = nil
    expect(@comment).not_to be_valid
  end
end
