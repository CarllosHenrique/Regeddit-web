# frozen_string_literal: true

module ServerList
  class Component < ViewComponent::Base
    def initialize(servers: [])
      @servers = servers
    end

    private

    attr_reader :servers
  end
end

