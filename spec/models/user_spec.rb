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
      expect(user.errors[:phone]).to include(I18n.t("errors.messages.invalid_phone"))
    end

    it "rejects bios longer than 320 characters" do
      user.bio = "a" * 321
      user.valid?
      expect(user.errors[:bio]).to include(I18n.t("errors.messages.too_long", count: 320))
    end
  end

  describe "callbacks" do
    describe "#set_username" do
      it "derives a username from the name when available" do
        user = build(:user, username: nil, name: "Ana M Silva")
        allow(User).to receive(:exists?).and_return(false)

        user.valid?

        expect(user.username).to eq("ana-m-silva")
      end

      it "falls back to a secure random username when all generators collide" do
        user = build(:user, username: nil, name: "")
        unique_generator = Class.new do
          def username(separators:)
            "dupuser"
          end

          def slug(words:, glue:)
            "dupslug"
          end
        end.new

        allow(Faker::Internet).to receive(:unique).and_return(unique_generator)
        allow(Faker::Name).to receive(:initials).and_return("AB")
        allow_any_instance_of(Object).to receive(:rand).with(10..99).and_return(42)
        allow(User).to receive(:exists?).and_return(true)
        allow(SecureRandom).to receive(:hex).and_return("cafebabe")

        user.valid?

        expect(user.username).to eq("ucafebabe")
      end

      it "does not override an explicitly set username" do
        user = build(:user, username: "meuuserescolhido")
        user.valid?
        expect(user.username).to eq "meuuserescolhido"
      end
    end
  end
end
