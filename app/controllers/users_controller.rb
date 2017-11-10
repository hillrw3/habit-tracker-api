class UsersController < ApplicationController

  def create
    user = User.new(user_params)

    return render json: user.errors.as_json unless user.save

    render json: user.as_json, status: :created
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end