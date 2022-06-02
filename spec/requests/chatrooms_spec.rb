# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatroomsController, type: :controller do
  login_user
  let! (:user2) {FactoryBot.create(:user)}
  let! (:user3) {FactoryBot.create(:user)}
  let(:valid_attributes_dm) do
    {
      'id' => '1',
      'direct' => true,
      'room_name' => '',
      'user_ids' => [user2.id]
    }
  end

  let(:invalid_attributes_dm) do
    {
      'id' => 'a',
      'direct' => false,
      'room_name' => '',
      'user_ids' => [user2.id, user3.id]
    }
  end

  let (:valid_attributes_group) do
    {
      'id' => '2',
      'direct' => false,
      'room_name' => 'new group',
      'user_ids' => [user2.id, user3.id]
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      chatroom = Chatroom.new(valid_attributes_dm)
      chatroom.save
      chatroom_user =ChatroomUser.new(id: 2, chatroom_id: chatroom.id, user_id: user.id, admin: true)
      chatroom_user.save
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      chatroom = Chatroom.new(valid_attributes_dm)
      chatroom.save
      chatroom_user =ChatroomUser.new(id: 2, chatroom_id: chatroom.id, user_id: user.id, admin: true)
      chatroom_user.save
      get :show, params: {id: chatroom.id}
      expect(response).to have_http_status(:success)
    end
  end
  describe 'GET /group' do
    it 'renders a successful response' do
      get :group
      expect(response).to be_successful
    end
  end
  describe 'get/edit' do
    it 'renders a successful response' do
      chatroom = Chatroom.new(valid_attributes_group)
      chatroom.save
      chatroom_user =ChatroomUser.new(id: chatroom.users.count + 1, chatroom_id: chatroom.id, user_id: user.id, admin: true)
      chatroom_user.save
      get :edit, params: {id: chatroom.id}
      expect(response).to be_successful
    end
    it 'cant edit dm' do
      chatroom = Chatroom.new(valid_attributes_dm)
      chatroom.save
      chatroom_user =ChatroomUser.new(id: chatroom.users.count + 1, chatroom_id: chatroom.id, user_id: user.id, admin: true)
      chatroom_user.save
      get :edit, params: {id: chatroom.id}

      expect(flash[:alert]).to include("Can't edit direct message")
      expect(response).to redirect_to(chatroom_path(chatroom))
    end
  end
  #hello
  describe 'POST /create' do
    context 'with valid parameters' do

      it 'does creates a DM chatroom' do
        expect do
          post :create, params: { chatroom: valid_attributes_dm, user_ids: [user2.id] }
        end.to change(Chatroom, :count).by(1)
      end

      it 'redirects to the created DM chatroom' do
        post :create, params: { chatroom: valid_attributes_dm, user_ids: [user2.id] }
        expect(response).to redirect_to(chatroom_url(Chatroom.last))
      end

      it 'does creates a DM chatroom' do
        expect do
          post :create, params: { chatroom: valid_attributes_group }
        end.to change(Chatroom, :count).by(1)
      end

      it 'redirects to the created group chatroom' do
        post :create, params: { chatroom: valid_attributes_group, user_ids: [user2.id] }
        expect(response).to redirect_to(chatroom_url(Chatroom.last))
      end
    end


    context 'with invalid parameters' do
      it 'does not create a chatroom' do
        expect do
          post :create, params: { post: invalid_attributes_dm, user_ids: [user2.id] }
        end.to change(Post, :count).by(0)
      end

      it "renders a successful response" do
        post :create, params: { post: invalid_attributes_dm, user_ids: [user2.id] }
        expect(response).to redirect_to(group_path)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          'room_name' => 'edited'
        }
      end

      it 'updates the requested group chatroom' do
        chatroom = Chatroom.new(valid_attributes_group)
        chatroom.save
        chatroom_user =ChatroomUser.new(id: chatroom.users.count + 1, chatroom_id: chatroom.id, user_id: user.id, admin: true)
        chatroom_user.save
        patch :update, params: { id: chatroom.id, post: new_attributes }
        chatroom.reload
        expect(response).to be_redirect
      end

      it 'redirects to the post' do
        chatroom = Chatroom.new(valid_attributes_group)
        chatroom.save
        chatroom_user =ChatroomUser.new(id: chatroom.users.count + 1, chatroom_id: chatroom.id, user_id: user.id, admin: true)
        chatroom_user.save
        patch :update, params: { id: chatroom.id, post: new_attributes }
        chatroom.reload
        expect(response).to redirect_to(edit_chatroom_path(chatroom))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_new_attributes) do
        {
          'room_name' => ''
        }
      end
      it "renders a successful response (i.e. to display the 'edit' template)" do
        chatroom = Chatroom.new(valid_attributes_group)
        chatroom.save
        chatroom_user =ChatroomUser.new(id: chatroom.users.count + 1, chatroom_id: chatroom.id, user_id: user.id, admin: true)
        chatroom_user.save
        patch :update, params: { id: chatroom.id, post: invalid_new_attributes }
        expect(response).to redirect_to(edit_chatroom_path(chatroom))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested post' do
      chatroom = Chatroom.new(valid_attributes_group)
      chatroom.save
      chatroom_user =ChatroomUser.new(id: chatroom.users.count + 1, chatroom_id: chatroom.id, user_id: user.id, admin: true)
      chatroom_user.save
      expect do
        delete :destroy, params: {id: chatroom.id}
      end.to change(Chatroom, :count).by(-1)

    end

    it 'redirects to the posts list' do
      chatroom = Chatroom.new(valid_attributes_group)
      chatroom.save
      chatroom_user =ChatroomUser.new(id: chatroom.users.count + 1, chatroom_id: chatroom.id, user_id: user.id, admin: true)
      chatroom_user.save
      delete :destroy, params: {id: chatroom.id}
      expect(response).to redirect_to(chatrooms_path)
    end
  end
end
