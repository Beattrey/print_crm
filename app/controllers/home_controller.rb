class HomeController < ApplicationController
  def index
    return unless user_signed_in?

    redirect_to profile_path(current_user)
  end
end
