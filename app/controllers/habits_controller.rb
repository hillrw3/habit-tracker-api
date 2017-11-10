class HabitsController < ApplicationController

  def index
    render json: current_user.habits.as_json(only: [:id, :title, :target_frequency, :actual_frequency])
  end

  def perform
    Habit.find(params[:id]).increment(:actual_frequency, 1).save

    render status: :no_content
  end
end