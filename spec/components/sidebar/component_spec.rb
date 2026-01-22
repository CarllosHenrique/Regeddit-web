# frozen_string_literal: true

require "rails_helper"

RSpec.describe Sidebar::Component, type: :component do
  let(:component) { described_class.new }

  before do
    allow(component).to receive(:user_signed_in?).and_return(false)
  end

  it "renders the sidebar navigation" do
    rendered = render_inline(component)

    expect(rendered.css("nav").first["class"]).to include("hidden sm:flex")
  end

  it "shows the server initials buttons" do
    rendered = render_inline(component)

    expect(rendered.text).to include("FE")
    expect(rendered.text).to include("JS")
  end
end
