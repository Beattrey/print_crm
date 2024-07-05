class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @current_user = current_user
    @print_maker = current_user.worker.print_maker
  end

  def edit
    @profile = current_user.profile
  end

  def update
  end

end
