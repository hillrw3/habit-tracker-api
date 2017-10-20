module ObjectCreation
  def create_user(options={})
    attributes = {
        username: 'cheeks',
        password: 'super_secure'
    }.merge(options)

    User.create!(attributes)
  end
end