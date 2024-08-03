class UserRolesHandler
  def initialize(user, params)
    @user = user
    @params = params
    @params.delete('id')
    @worker = @user.worker
  end

  def call
    current_roles = @user.worker.roles.map(&:account_type) # Получаем имена текущих ролей
    @params.each do |role_name, action|
      has_role = current_roles.include?(role_name)
      if action.to_i == 1 && !has_role
        @worker.send("create_#{role_name}")
      elsif action.to_i == 0 && has_role
        role_name.camelize.constantize.find_by(worker_id: @worker.id)&.destroy
      end
    end
  end
end
