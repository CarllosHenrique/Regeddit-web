require 'rails_helper'

RSpec.describe NavbarHelper, type: :helper do
  describe '#nav_link' do
    let(:path) { '/some/path' }

    it 'returns a bold, white link when pointing to the current page' do
      allow(helper).to receive(:current_page?).with(path).and_return(true)

      html = helper.nav_link('Home', path)

      expect(html).to include('text-white font-semibold')
      expect(html).to include("href=\"#{path}\"")
      expect(html).to include('Home')
    end

    it 'returns a muted link when pointing elsewhere' do
      allow(helper).to receive(:current_page?).with(path).and_return(false)

      html = helper.nav_link('Home', path)

      expect(html).to include('text-gray-300 hover:text-white')
      expect(html).to include("href=\"#{path}\"")
    end
  end
end
