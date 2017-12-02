require_relative '../spec/helpers/object_creation'

class Creator
  extend ObjectCreation
end

rob = Creator.create_user(email: 'rob@example.com', password: 'password')
Creator.create_habit(title: 'go for a jog', user_id: rob.id)
Creator.create_habit(title: 'write all the code', user_id: rob.id)