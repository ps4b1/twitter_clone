# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  login_user
  let!(:tweet) {FactoryBot.create(:post, user: user)}
  let(:valid_attributes) do
    {
      'likeable_type' => tweet.class,
      'likeable_id' => tweet.id,
    }
  end
  let(:invalid_attributes) do
    {
      'commentable_type' => '',
      'commentable_id' => 'tweet.id'
    }
  end
  describe 'POST /create' do
    context 'with valid parameters' do

      it 'does creates a like' do
        expect do
          post :create, params: { like: valid_attributes }
        end.to change(Like, :count).by(1)
      end

      it 'redirects to the home page' do
        post :create, params: { like: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a like' do
        expect do
          post :create, params: { like: invalid_attributes }
        end.to change(Like, :count).by(0)
      end

      it "renders a successful response" do
        post :create, params: { like: invalid_attributes }
        expect(flash[:alert]).to include('Something went wrong')
      end
    end
  end
  describe 'DELETE /destroy' do
    it 'destroys the requested post' do
      like=Like.new(valid_attributes)
      like.user = user
      like.save
      expect do
        delete :destroy, params: {id: like.id}
      end.to change(Like, :count).by(-1)

    end

    it 'redirects to the posts list' do
      like=Like.new(valid_attributes)
      like.user = user
      like.save
      delete :destroy, params: {id: like.id}
      expect(response).to redirect_to(root_path)
    end
  end
end
