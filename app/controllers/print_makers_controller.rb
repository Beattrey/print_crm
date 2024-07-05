class PrintMakersController < ApplicationController
  def show
    @print_maker = current_user.print_maker
  end

  def edit
    @print_maker = current_user.print_maker
  end

  def update
    @print_maker = current_user.print_maker
    if @print_maker.update(print_maker_params)
      redirect_to profile_path, notice: 'Статус успішно оновлено.'
    else
      render :show, alert: 'Не вдалося оновити статус.'
    end
  end

  private

  def print_maker_params
    params.require(:print_maker).permit(
      :status,
      :name,
      filament_ids: []
    )
  end
end
