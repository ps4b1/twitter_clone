# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  login_user
  let!(:tweet) {FactoryBot.create(:post, user: user)}
  let(:valid_attributes) do
    {
      'description' => 'new content',
      'commentable_type' => tweet.class,
      'commentable_id' => tweet.id,
    }
  end
  let(:invalid_attributes) do
    {
      'description' => '',
      'commentable_type' => tweet.class,
      'commentable_id' => tweet.id
    }
  end
  describe 'POST /create' do
    context 'with valid parameters' do

      it 'does creates a comments' do
        expect do
          post :create, params: { comment: valid_attributes }
        end.to change(Comment, :count).by(1)
      end

      it 'redirects to the home page' do
        post :create, params: { comment: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a Post' do
        expect do
          post :create, params: { comment: invalid_attributes }
        end.to change(Comment, :count).by(0)
      end

      it "renders a successful response" do
        post :create, params: { comment: invalid_attributes }
        expect(flash[:alert]).to include('Something went wrong')
      end
    end
  end
  describe 'DELETE /destroy' do
    it 'destroys the requested like' do
      comment=Comment.new(valid_attributes)
      comment.user = user
      comment.save
      expect do
        delete :destroy, params: {id: comment.id}
      end.to change(Comment, :count).by(-1)

    end

    it 'redirects to the posts list' do
      comment=Comment.new(valid_attributes)
      comment.user = user
      comment.save
      delete :destroy, params: {id: comment.id}
      expect(response).to redirect_to(root_path)
    end
  end
end
