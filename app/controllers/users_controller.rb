class UsersController < ApplicationController
  skip_before_action :authenticate_user

  def create
    user = User.new(user_params)

    return render json: user.errors.as_json unless user.save

    render json: user.as_json, status: :created
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end