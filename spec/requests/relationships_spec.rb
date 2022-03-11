# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  describe 'GET /create' do
    it 'returns http success' do
      get '/relationship/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/relationship/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
