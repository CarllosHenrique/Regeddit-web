require "rails_helper"
require "securerandom"

RSpec.describe User, type: :model do
  describe "#set_username" do
    it "generates username from name when blank" do
      name = "Lucas Crick #{SecureRandom.hex(4)}"
      user = build(:user, name: name, username: "")

      user.validate

      expect(user.username).to eq(name.strip.parameterize(separator: "."))
    end

    it "adds a suffix when generated username already exists" do
      name = "Test User #{SecureRandom.hex(4)}"
      base = name.strip.parameterize(separator: ".")

      create(:user, name: name, username: "")
      user = build(:user, name: name, username: "")

      user.validate

      expect(user.username).to eq("#{base}.2")
    end
  end
end
