require_relative '../../lib/calendar'

class User < ApplicationRecord
  has_secure_password

  has_many :habits
  has_many :current_habits, -> { where('created_at >= ?', Calendar.beginning_of_week) }, class_name: 'Habit'

  def self.authenticate(email, password)
    user = User.find_by(email: email)

    return unless (user && user.authenticate(password))

    token = SecureRandom.base64
    user.update(api_token: token)
    return token
  end
end