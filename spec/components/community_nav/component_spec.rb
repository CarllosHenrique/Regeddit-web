# frozen_string_literal: true

require "rails_helper"

RSpec.describe CommunityNav::Component, type: :component do
  it "renders the main section headings" do
    rendered = render_inline(described_class.new)

    expect(rendered.text).to include("Discussions", "Voice & Live", "Active Threads")
  end

  it "exposes the primary discussion links" do
    rendered = render_inline(described_class.new)

    expect(rendered.text).to include("general-dev", "Lounge", "State Management...")
  end
end
