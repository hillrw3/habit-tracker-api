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
end