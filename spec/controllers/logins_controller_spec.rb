require 'rails_helper'

describe LoginsController do
  describe 'POST #create' do
    context 'on success' do
      it 'returns a token' do
        params = {username: 'bob', password: 'hello'}
        create_user(params)

        response = post :create, params: params

        expect(response.status).to eq 201
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['token']).not_to be_nil
      end
    end
  end
end