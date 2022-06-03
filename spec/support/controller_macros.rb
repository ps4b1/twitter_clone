# frozen_string_literal: true

module ControllerMacros
  def login_user
    let!(:user) { FactoryBot.create(:user) }
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user
    end
  end
end
