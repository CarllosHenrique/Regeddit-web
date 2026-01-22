require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "requires a name between 2 and 50 characters" do
      user.name = ""
      user.valid?
      expect(user.errors[:name]).to include(I18n.t("errors.messages.blank"))

      user.name = "A"
      user.valid?
      expect(user.errors[:name]).to include(I18n.t("errors.messages.too_short", count: 2))
    end

    it "requires a username between 3 and 30 characters" do
      allow(user).to receive(:set_username)

      user.username = nil
      user.valid?
      expect(user.errors[:username]).to include(I18n.t("errors.messages.blank"))

      user.username = "ab"
      user.valid?
      expect(user.errors[:username]).to include(I18n.t("errors.messages.too_short", count: 3))
    end

    it "enforces username uniqueness" do
      allow(user).to receive(:set_username)

      existing_user = create(:user)
      user.username = existing_user.username
      user.valid?
      expect(user.errors[:username]).to include(I18n.t("errors.messages.taken"))
    end

    it "requires a properly formatted email" do
      user.email = "invalid"
      user.valid?
      expect(user.errors[:email]).to include(I18n.t("errors.messages.invalid"))
    end

    it "enforces email uniqueness" do
      existing_user = create(:user)
      user.email = existing_user.email
      user.valid?
      expect(user.errors[:email]).to include(I18n.t("errors.messages.taken"))
    end

    it "allows blank phone and bio" do
      user.phone = ""
      user.bio = ""
      expect(user).to be_valid
    end

    it "rejects invalid phone formats" do
      user.phone = "abc123"
      user.valid?
      expect(user.errors[:phone]).to include(I18n.t("errors.messages.invalid"))
    end

    it "rejects bios longer than 500 characters" do
      user.bio = "a" * 501
      user.valid?
      expect(user.errors[:bio]).to include(I18n.t("errors.messages.too_long", count: 500))
    end
  end

  describe "callbacks" do
    describe "#set_username" do
      it "auto-generates a unique username if none is provided" do
        user = build(:user, username: nil)
        expect { user.valid? }.to change { user.username }.from(nil).to(be_present)
      end

      it "does not overwrite an explicitly set username" do
        user = build(:user, username: "meuuserescolhido")
        user.valid?
        expect(user.username).to eq "meuuserescolhido"
      end
    end
  end
end
