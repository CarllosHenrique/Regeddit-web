# frozen_string_literal: true

require "rails_helper"

RSpec.describe Navbar::NavbarComponent, type: :component do
  it "renders the navbar with responsive classes" do
    render_inline(described_class.new)
    
    expect(page).to have_css("nav")
    expect(page).to have_text("Regeddit?")
  end

  it "includes mobile menu toggle button" do
    render_inline(described_class.new)
    
    expect(page).to have_css("button[data-action='click->mobile-menu#toggle']")
    expect(page).to have_css(".fa-bars")
  end

  it "includes mobile menu that is hidden by default" do
    render_inline(described_class.new)
    
    expect(page).to have_css(".hidden[data-mobile_menu_target='menu']")
  end

  it "has proper touch target size for mobile buttons" do
    render_inline(described_class.new)
    
    # Check minimum touch target size (44px)
    expect(page).to have_css("button.min-w-\\[44px\\].min-h-\\[44px\\]")
  end
end
