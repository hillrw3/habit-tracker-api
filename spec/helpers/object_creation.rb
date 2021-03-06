module ObjectCreation
  def create_user(options={})
    attributes = {
        email: 'cheeks@example.com',
        password: 'super_secure'
    }.merge(options)

    User.create!(attributes)
  end

  def create_user_with_token(options={})
    create_user(options.merge(api_token: SecureRandom.base64))
  end

  def create_habit(options={})
    user_id = options[:user_id] || create_user.id
    attributes = {
        title: 'go on a run',
        user_id: user_id,
        target_frequency: 2,
    }.merge(options)

    Habit.create!(attributes)
  end
end