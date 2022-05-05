# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @post = Post.new(content: 'post', user_id: @user.id, id: 1)
  end
  context 'not repost' do
    it 'should be valid' do
      expect(@post).to be_valid
    end
    it 'is not valid without user' do
      @post.user_id = nil
      expect(@post).not_to be_valid
    end
    it 'is not valid without content' do
      @post.content = nil
      expect(@post).not_to be_valid
    end
  end
  context 'repost' do
    before do
      @test_post = FactoryBot.create(:post)
      @post = Post.new(user_id: @user.id, id: 1, content: 'Repost', repostable: @test_post)
    end
    it 'should be valid with everything' do
      expect(@post).to be_valid
    end
    it 'should be valid without content' do
      @post.content = nil
      expect(@post).to be_valid
    end
  end
end
