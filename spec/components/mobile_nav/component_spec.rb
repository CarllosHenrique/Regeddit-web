# frozen_string_literal: true

require "rails_helper"

RSpec.describe MobileNav::Component, type: :component do
  it "renders the primary navigation badges" do
    rendered = render_inline(described_class.new)

    expect(rendered.css("nav").first["class"]).to include("md:hidden")
    expect(rendered.text).to include("Home", "Explore", "Chat", "Profile")
  end

  it "renders the floating action button" do
    rendered = render_inline(described_class.new)

    expect(rendered.css("iconify-icon[icon='lucide:plus']").count).to eq(1)
  end
end
