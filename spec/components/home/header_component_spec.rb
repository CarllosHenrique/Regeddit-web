# frozen_string_literal: true

require "rails_helper"

RSpec.describe Home::HeaderComponent, type: :component do
  let(:user) { double("User", name: "John Doe", bio: "Test bio", present?: true) }

  context "when user is logged in" do
    it "renders user information with responsive typography" do
      render_inline(described_class.new(user: user))
      
      expect(page).to have_text("John")
      expect(page).to have_text("Test bio")
    end

    it "has responsive font sizes for mobile and desktop" do
      render_inline(described_class.new(user: user))
      
      # Check for responsive text classes
      expect(page).to have_css(".text-xl.md\\:text-2xl")
    end

    it "includes navigation links with minimum touch targets" do
      render_inline(described_class.new(user: user))
      
      expect(page).to have_css("a.min-h-\\[44px\\]", minimum: 4)
    end

    it "truncates long text to prevent overflow" do
      render_inline(described_class.new(user: user))
      
      expect(page).to have_css(".truncate")
    end
  end

  context "when user is not logged in" do
    it "renders welcome message" do
      render_inline(described_class.new(user: nil))
      
      expect(page).to have_text("Welcome to Regeddit")
    end

    it "includes login link with responsive sizing" do
      render_inline(described_class.new(user: nil))
      
      expect(page).to have_css("a[href*='sign_in']")
      expect(page).to have_css(".min-h-\\[44px\\]")
    end
  end
end
