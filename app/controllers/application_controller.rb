class ApplicationController < ActionController::API
  before_action :authenticate_user

  def authenticate_user
    return render status: :unauthorized unless request.headers['X-AUTH-TOKEN']
    return render status: :unauthorized unless current_user
  end

  def current_user
    @current_user ||= User.find_by(api_token: request.headers['X-AUTH-TOKEN'])
  end
end
