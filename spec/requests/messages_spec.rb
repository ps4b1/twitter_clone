# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  login_user
  let!(:user2) {FactoryBot.create(:user)}
  let!(:chatroom) {FactoryBot.create(:chatroom)}
  let (:valid_attributes) do
    {
      'content' => 'new message',
      'user_id' => user.id,
      'chatroom_id' => chatroom.id
    }
    end
  let (:invalid_attributes) do
    {
      'content' => '',
      'user_id' => 'string',
      'chatroom_id' => 'string'
    }
  end
  describe 'POST /create' do
    it 'creates message with valid attributes' do
      expect do
        post :create, params: { message: valid_attributes }
      end.to change(Message, :count).by(1)
    end
    it 'doesnt create message with invalid attributes' do
      expect do
        post :create, params: { message: invalid_attributes }
      end.to change(Message, :count).by(0)
    end
  end
end
