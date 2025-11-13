require 'rails_helper'

RSpec.describe "HomeController", type: :request do
  describe "GET /" do
    it "returns a successful response" do
      user = create(:user)
      sign_in user, scope: :user
      get root_path
      expect(response).to be_successful
    end
  end
end