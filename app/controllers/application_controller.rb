class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  allow_browser versions: :modern

  stale_when_importmap_changes
end
