# frozen_string_literal: true

require "rails_helper"

RSpec.describe AuthBrandingPanel::Component, type: :component do
  it "renders the default quote block" do
    rendered = render_inline(described_class.new)

    expect(rendered.text).to include("Nexus mudou completamente", "Sofia Andrade", "CTO na TechFlow")
    expect(rendered.css("img[alt='User']").first["src"]).to include("i.pravatar.cc")
  end

  it "allows overriding the author metadata" do
    rendered = render_inline(
      described_class.new(
        quote: "Custom quote",
        author_name: "Ana",
        author_title: "Founder, Studio",
        avatar_url: "https://example.com/avatar.png"
      )
    )

    expect(rendered.text).to include("Custom quote", "Ana", "Founder, Studio")
    expect(rendered.css("img[alt='User']").first["src"]).to eq("https://example.com/avatar.png")
  end
end
