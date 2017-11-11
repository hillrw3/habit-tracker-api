require_relative '../../lib/calendar'

class User < ApplicationRecord
  has_secure_password

  has_many :habits

  def self.authenticate(username, password)
    user = User.find_by(username: username)

    return unless (user && user.authenticate(password))

    token = SecureRandom.base64
    user.update(api_token: token)
    return token
  end

  def current_habits
    habits.where('created_at >= ?', Calendar.beginning_of_week)
  end
end