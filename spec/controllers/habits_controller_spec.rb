require 'rails_helper'

describe HabitsController do
  describe 'GET index' do
    context 'with a valid token' do
      it 'returns a list of habits for user' do
        user = create_user(api_token: 'token')
        create_habit(title: 'go on a run', user_id: user.id)
        create_habit(title: 'vacuum', user_id: user.id)

        request.headers.merge!({'X-AUTH-TOKEN' => user.api_token})
        response = get :index

        expect(response.status).to eq 200
        body = JSON.parse(response.body)
        expect(body).to match_array([{'title' => 'go on a run'}, {'title' => 'vacuum'}])
      end
    end

    context 'without a valid token' do
      it 'returns a 401' do
        request.headers.merge!({'X-AUTH-TOKEN' => 'some made up token'})
        response = get :index

        expect(response.status).to eq 401
      end
    end
  end
end