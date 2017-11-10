class LoginsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    token = User.authenticate(params[:username], params[:password])

    return render status: :unauthorized unless token

    render json: {token: token}, status: :created
  end
end