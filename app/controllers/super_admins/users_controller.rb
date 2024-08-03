module SuperAdmins
  class UsersController < ApplicationController
    before_action :check_super_admin

    def index
      @users = User.all
    end

    def update_roles
      params[:users].each do |_index, user_params|
        user = User.find(user_params[:id])
        UserRolesHandler.new(user, user_params).call
      end
      redirect_to super_admins_users_path, notice: 'Ролі успішно оновлено'
    end

    private

    def check_super_admin
      redirect_to root_path, alert: "Access denied!" unless current_user.super_admin
    end

    def user_params
      params.require(:users).permit!
    end
  end
end
