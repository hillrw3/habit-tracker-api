class ApplicationController < ActionController::API
  before_action :authenticate_user

  def authenticate_user
    return render status: :unauthorized unless x_auth_token && current_user
  end

  def current_user
    @current_user ||= User.find_by(api_token: x_auth_token)
  end

  private

  def x_auth_token
    request.headers['X-AUTH-TOKEN']
  end
end
