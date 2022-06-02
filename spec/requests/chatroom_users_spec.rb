# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatroomUsersController, type: :controller do
  login_user
  let!(:user2) {FactoryBot.create(:user)}
  let!(:chatroom) {FactoryBot.create(:chatroom)}
  let(:valid_attributes) do
    {
      'admin' => false,
      'chatroom_id' => chatroom.id
    }
  end
  let(:invalid_attributes) do
    {
      'admin' => 'string',
      'chatroom_id' => "a"
    }
  end
  describe 'DELETE /destroy' do
    it 'destroys the requested chatroom_user and chatroom when 0 users in chatroom' do
      chatroom_user =ChatroomUser.new(valid_attributes)
      chatroom_user.user_id = user.id
      chatroom_user.save
      expect do
        delete :destroy, params: {id: chatroom_user.id, user: user.id, chatroom: chatroom}
      end.to change(ChatroomUser, :count).by(-1) and change(Chatroom, :count).by(-1)
    end

    it 'destroys the requested chatroom_user and chatroom when more than 0 users in chatroom' do
      chatroom_user =ChatroomUser.new(valid_attributes)
      chatroom_user.user_id = user.id
      chatroom_user.admin=true
      chatroom_user.save
      chatroom_user =ChatroomUser.new(valid_attributes)
      chatroom_user.user_id = user.id
      chatroom_user.save
      expect do
        delete :destroy, params: {id: chatroom_user.id, user: user.id, chatroom: chatroom}
      end.to change(ChatroomUser, :count).by(-1)
    end
    it 'redirects to the chatroom list when 0 users in chatroom' do
      chatroom_user =ChatroomUser.new(valid_attributes)
      chatroom_user.user_id = user.id
      chatroom_user.save
      delete :destroy, params: {id: chatroom_user.id, user: user.id, chatroom: chatroom}
      expect(response).to redirect_to(chatrooms_path)
    end

    it 'redirects to the chatroom list when more than 0 users in chatroom' do
      chatroom_user =ChatroomUser.new(valid_attributes)
      chatroom_user.user_id = user.id
      chatroom_user.admin=true
      chatroom_user.save
      chatroom_user2 =ChatroomUser.new(valid_attributes)
      chatroom_user2.user_id = user2.id
      chatroom_user2.save
      delete :destroy, params: {id: chatroom_user2.id, user: user2.id, chatroom: chatroom}
      expect(response).to redirect_to(edit_chatroom_path(chatroom))
    end

  end
end
