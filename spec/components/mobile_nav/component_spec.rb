# frozen_string_literal: true

require "rails_helper"

RSpec.describe MobileNav::Component, type: :component do
  let(:component) { described_class.new }

  before do
    allow(component).to receive(:user_signed_in?).and_return(false)
    allow(component).to receive(:current_user).and_return(nil)
  end

    it "renders the primary navigation badges" do
      rendered = render_inline(component)

      expect(rendered.css("nav").first["class"]).to include("md:hidden")
      expect(rendered.text).to include(
        I18n.t("mobile_nav.home"),
        I18n.t("mobile_nav.explore"),
        I18n.t("mobile_nav.chat"),
        I18n.t("mobile_nav.profile")
      )
    end

  it "renders the floating action button" do
    rendered = render_inline(component)

    expect(rendered.css("iconify-icon[icon='lucide:plus']").count).to eq(1)
  end
end
