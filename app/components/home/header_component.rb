# frozen_string_literal: true

class Home::HeaderComponent < ApplicationComponent
  def initialize(user:)
    @user = user
  end

  private

  attr_reader :user

  def logged_in?
    user.present?
  end

  def user_full_name
    user&.name&.capitalize
  end

  def user_bio
    user&.bio
  end
end
