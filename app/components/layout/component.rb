# frozen_string_literal: true

module Layout
  class Component < ViewComponent::Base
    renders_one :container
    renders_one :members

    def initialize(server_name: "Server Name", username: "Username", discriminator: "#1234", avatar_url: nil)
      @server_name = server_name
      @username = username
      @discriminator = discriminator
      @avatar_url = avatar_url
    end

    private

    attr_reader :server_name, :username, :discriminator, :avatar_url
  end
end

