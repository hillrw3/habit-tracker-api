class HabitsController < ApplicationController

  def index
    render json: current_user.current_habits.as_json(only: [:id, :title, :target_frequency, :actual_frequency])
  end

  def create
    habit = Habit.new(habit_params)

    habit.save

    render json: habit.as_json
  end

  def perform
    habit = current_user.habits.find_by(id: params[:id])

    return render status: :forbidden unless habit

    habit.increment(:actual_frequency, 1).save
    render status: :no_content
  end

  private

  def habit_params
    params.require(:habit).permit(:title, :target_frequency)
    .merge(user_id: current_user.id)
  end
end