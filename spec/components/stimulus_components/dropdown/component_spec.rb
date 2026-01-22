# frozen_string_literal: true

require "rails_helper"

RSpec.describe StimulusComponents::Dropdown::Component, type: :component do
  def render_dropdown(placement: :top_end, menu_class: nil)
    render_inline(described_class.new(placement: placement, menu_class: menu_class)) do |c|
      c.with_trigger { "<button type='button'>User</button>".html_safe }
      c.with_menu { "<div>Menu</div>".html_safe }
    end
  end

  it "renders a stimulus dropdown wrapper" do
    rendered = render_dropdown

    expect(rendered.css("[data-controller='dropdown']").count).to eq(1)
    expect(rendered.css("[data-dropdown-target='trigger']").count).to eq(1)
    expect(rendered.css("[data-dropdown-target='menu']").count).to eq(1)
  end

  describe "menu positioning" do
    {
      top_end: %w[bottom-full right-0 origin-bottom-right],
      top_start: %w[bottom-full left-0 origin-bottom-left],
      bottom_start: %w[top-full left-0 origin-top-left],
      bottom_end: %w[top-full right-0 origin-top-right]
    }.each do |placement, expected_classes|
      it "applies #{placement} classes" do
        rendered = render_dropdown(placement: placement)
        menu = rendered.css("[data-dropdown-target='menu']").first

        expected_classes.each do |expected_class|
          expect(menu["class"]).to include(expected_class)
        end
      end
    end

    it "falls back to bottom_end when placement is missing" do
      rendered = render_dropdown(placement: nil)
      menu = rendered.css("[data-dropdown-target='menu']").first

      expect(menu["class"]).to include("top-full")
      expect(menu["class"]).to include("origin-top-right")
    end
  end

  it "includes additional menu classes when provided" do
    rendered = render_dropdown(menu_class: "custom-menu")
    menu = rendered.css("[data-dropdown-target='menu']").first

    expect(menu["class"]).to include("custom-menu")
  end
end
