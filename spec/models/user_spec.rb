# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(username: 'userTest', email: 'userTest@example.com', password: '123456',
                     password_confirmation: '123456')
  end
  it 'should be valid' do
    expect(@user).to be_valid
  end
  it 'should not be valid without username' do
    @user.username = nil
    expect(@user).not_to be_valid
  end
  context 'password' do
    it 'should not be valid without password' do
      @user.password = nil
      expect(@user).not_to be_valid
    end
    it 'should not be valid without confirmation password' do
      @user.password = nil
      expect(@user).not_to be_valid
    end
    it 'should not have different password and confirmation password' do
      @user.password_confirmation = "#{@user.password}1"
      expect(@user).not_to be_valid
    end
  end
  context 'uniqueness' do
    before { @test_user = FactoryBot.create(:user) }
    it 'should have unique username' do
      @user.username = @test_user.username
      expect(@user).not_to be_valid
    end
    it 'should have unique email' do
      @user.email = @test_user.email
      expect(@user).not_to be_valid
    end
  end
end
