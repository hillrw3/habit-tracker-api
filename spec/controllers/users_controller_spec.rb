require 'rails_helper'

describe UsersController do
  describe 'POST #create' do
    let(:user_params) { {user: {username: 'cheeks', password: 'superSecur3', password_confirmation: 'superSecur3'}} }

    it 'creates a new user' do
      expect { post :create, params: user_params }.to change { User.count }.by(1)
    end

    it 'requires password and password_confirmation to match' do
      user_params[:user][:password_confirmation] = 'some_random_thing'

      expect { post :create, params: user_params }.to change { User.count }.by(0)

      errors = JSON.parse(response.body)

      expect(errors['password_confirmation']).to match_array(["doesn't match Password"])
    end
  end
end