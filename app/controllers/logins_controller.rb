class LoginsController < ApplicationController

  def create
    user = User.find_by(username: params[:username])

    if !(user && user.authenticate(params[:password]))
      return render status: :unauthorized
    end

    render json: {token: 'badge'}, status: :created
  end
end