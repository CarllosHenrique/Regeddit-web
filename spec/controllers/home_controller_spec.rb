require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  it "returns a successful response" do
    get :index
    expect(response).to have_http_status(:success)
  end
end
