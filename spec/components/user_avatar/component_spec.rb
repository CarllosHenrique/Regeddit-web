# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserAvatar::Component, type: :component do
  let(:component) { described_class.new(user: user, size: size) }
  let(:size) { :medium }
  let(:name) { "Ana" }
  let(:username) { "ana" }
  let(:avatar_attached) { true }
  let(:avatar) { instance_double(ActiveStorage::Attached::One, attached?: avatar_attached) }
  let(:user) { instance_double("User", name: name, username: username, avatar: avatar) }

  before do
    allow_any_instance_of(UserAvatar::Component).to receive(:url_for).and_return("/avatar.png")
  end

  context "when the user has an avatar" do
    it "renders an image with the localized alt text and shared classes" do
      rendered = render_inline(component)

      image = rendered.css("img").first

      expect(image["src"]).to eq("/avatar.png")
      expect(image["alt"]).to eq(I18n.t("components.user_avatar.alt", name: "Ana"))
      expect(image["class"]).to eq("rounded-full bg-surface flex items-center justify-center overflow-hidden w-12 h-12")
    end

    context "without a name" do
      let(:name) { nil }

      it "uses the username for the alt text" do
        rendered = render_inline(component)

        expect(rendered.css("img").first["alt"]).to eq(I18n.t("components.user_avatar.alt", name: "ana"))
      end
    end

    context "without name or username" do
      let(:name) { nil }
      let(:username) { nil }

      it "falls back to the locale default name" do
        rendered = render_inline(component)

        expect(rendered.css("img").first["alt"]).to eq(
          I18n.t("components.user_avatar.alt", name: I18n.t("components.user_avatar.default_name"))
        )
      end
    end
  end

  context "when the user has no avatar" do
    let(:avatar_attached) { false }
    let(:name) { nil }
    let(:username) { nil }

    it "renders the placeholder icon with the computed class and width" do
      rendered = render_inline(component)

      icon = rendered.css("iconify-icon").first

      expect(icon["class"]).to include("rounded-full bg-surface flex items-center justify-center overflow-hidden w-12 h-12 text-textMuted")
      expect(icon["width"]).to eq("24")
    end

    context "with a small size" do
      let(:size) { :small }

      it "shrinks the icon and updates the stroke width" do
        rendered = render_inline(component)

        icon = rendered.css("iconify-icon").first

        expect(icon["class"]).to include("w-7 h-7")
        expect(icon["width"]).to eq("14")
      end
    end
  end
end
