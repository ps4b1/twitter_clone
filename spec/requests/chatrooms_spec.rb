# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatroomsController, type: :controller do
  login_user
  describe 'GET /create' do
    it 'returns http success' do
      get '/chatrooms/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/chatrooms/destroy'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/chatrooms/show'
      expect(response).to have_http_status(:success)
    end
  end
end
