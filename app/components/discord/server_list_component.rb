# frozen_string_literal: true

module Discord
  class ServerListComponent < ViewComponent::Base
    def initialize(servers: [])
      @servers = servers
    end

    private

    attr_reader :servers
  end
end
