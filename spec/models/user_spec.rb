require "rails_helper"

RSpec.describe User, type: :model do
  describe "#set_username" do
    it "generates username from name when blank" do
      user = build(:user, name: "Lucas Crick", username: "")

      user.validate

      expect(user.username).to eq("lucas.crick")
    end

    it "adds a suffix when generated username already exists" do
      create(:user, name: "Test User", username: "")
      user = build(:user, name: "Test User", username: "")

      user.validate

      expect(user.username).to eq("test.user.2")
    end
  end
end
