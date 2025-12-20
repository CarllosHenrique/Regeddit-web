# frozen_string_literal: true

class SideGroupList::SideGroupListComponent < ApplicationComponent
  def render?
    user_signed_in?
  end
end
