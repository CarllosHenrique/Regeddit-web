# frozen_string_literal: true

class ApplicationComponent < ViewComponent::Base
  include Devise::Controllers::Helpers
  include Rails.application.helpers
end
