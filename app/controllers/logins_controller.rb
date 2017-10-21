class LoginsController < ApplicationController

  def create
    token = User.authenticate(params[:username], params[:password])

    return render status: :unauthorized unless token

    render json: {token: token}, status: :created
  end
end