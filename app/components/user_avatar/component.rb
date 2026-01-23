# frozen_string_literal: true

module UserAvatar
  class Component < ApplicationComponent
    def initialize(user:, size: :medium)
      @user = user
      @size = size
    end

    private

    attr_reader :user, :size

    def classes
      "rounded-full bg-surface flex items-center justify-center overflow-hidden w-#{size_value} h-#{size_value}"
    end

    def icon_size
      size_value * 2
    end

    def image_src
      return unless user&.avatar&.attached?

      url_for(user.avatar)
    end

    def display_name
      user&.name.presence || user&.username.presence || I18n.t("components.user_avatar.default_name")
    end

    def size_value
      { small: 7, medium: 12, large: 16 }.fetch(size, 12)
    end
  end
end
