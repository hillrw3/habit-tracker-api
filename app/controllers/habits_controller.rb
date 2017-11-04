class HabitsController < ApplicationController
  def index
    user = User.find_by(api_token: request.headers['X-AUTH-TOKEN'])

    return render status: :unauthorized unless user

    render json: user.habits.as_json(only: :title)
  end
end