# frozen_string_literal: true

require "rails_helper"

RSpec.describe Dropdown::Component, type: :component do
  it "renders a stimulus dropdown wrapper" do
    rendered = render_inline(described_class.new(placement: :top_end)) do |c|
      c.with_trigger { "<button type='button'>User</button>".html_safe }
      c.with_menu { "<a href='#'>Profile</a>".html_safe }
    end

    expect(rendered.css("[data-controller='dropdown']").count).to eq(1)
    expect(rendered.css("[data-dropdown-target='trigger']").count).to eq(1)
    expect(rendered.css("[data-dropdown-target='menu']").count).to eq(1)
  end

  it "applies placement classes" do
    rendered = render_inline(described_class.new(placement: :top_end)) do |c|
      c.with_trigger { "<button type='button'>User</button>".html_safe }
      c.with_menu { "<div>Menu</div>".html_safe }
    end

    menu = rendered.css("[data-dropdown-target='menu']").first
    expect(menu["class"]).to include("bottom-full")
    expect(menu["class"]).to include("right-0")
  end
end
