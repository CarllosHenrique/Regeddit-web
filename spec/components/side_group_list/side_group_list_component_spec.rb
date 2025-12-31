# frozen_string_literal: true

require "rails_helper"

RSpec.describe SideGroupList::SideGroupListComponent, type: :component do
  let(:user) { double("User") }

  before do
    allow_any_instance_of(described_class).to receive(:user_signed_in?).and_return(true)
  end

  it "renders sidebar with mobile toggle button" do
    render_inline(described_class.new)
    
    expect(page).to have_css("button[data-action='click->sidebar#toggle']")
  end

  it "has sidebar with responsive transform classes" do
    render_inline(described_class.new)
    
    expect(page).to have_css("aside[data-sidebar_target='sidebar']")
    expect(page).to have_css("aside.lg\\:translate-x-0")
  end

  it "includes backdrop for mobile overlay" do
    render_inline(described_class.new)
    
    expect(page).to have_css(".hidden[data-sidebar_target='backdrop']")
  end

  it "has close button for mobile" do
    render_inline(described_class.new)
    
    expect(page).to have_css("button[data-action='click->sidebar#close']")
    expect(page).to have_css(".fa-times")
  end
end
