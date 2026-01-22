# frozen_string_literal: true

require "rails_helper"

RSpec.describe TrendingSidebar::Component, type: :component do
  it "renders the trending topics preview" do
    rendered = render_inline(described_class.new)

    expect(rendered.text).to include("Trending Worldwide", "Show more", "#OpenAI")
  end

  it "shows the community rules and online users" do
    rendered = render_inline(described_class.new)

    expect(rendered.text).to include("Community Rules", "Be respectful to others.", "Online — 1,402")
    expect(rendered.text).to include("Admin_Dave", "Sarah_Design")
  end
end
