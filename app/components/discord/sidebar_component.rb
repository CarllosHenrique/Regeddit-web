# frozen_string_literal: true

module Discord
  class SidebarComponent < ViewComponent::Base
    def initialize(server_name: "Server Name", username: "Username", discriminator: "#1234", avatar_url: nil)
      @server_name = server_name
      @username = username
      @discriminator = discriminator
      @avatar_url = avatar_url || "https://cdn.discordapp.com/embed/avatars/0.png"
    end

    private

    attr_reader :server_name, :username, :discriminator, :avatar_url
  end
end
