require 'rails_helper'

describe HabitsController do
  describe 'GET index' do
    context 'with a valid token' do
      it 'returns a list of habits created in the current week' do
        user = create_user_with_token
        habit_1 = create_habit(title: 'go on a run', user_id: user.id, target_frequency: 2, actual_frequency: 1)
        habit_2 = create_habit(title: 'vacuum', user_id: user.id, target_frequency: 1)
        old_habit = create_habit(user_id: user.id, created_at: 2.weeks.ago)
        other_user_habit = create_habit

        request.headers.merge!({'X-AUTH-TOKEN' => user.api_token})
        response = get :index

        expect(response.status).to eq 200
        body = JSON.parse(response.body)
        expect(body).to match_array([
                                {'id' => habit_1.id, 'title' => 'go on a run', 'target_frequency' => 2, 'actual_frequency' => 1},
                                {'id'=> habit_2.id, 'title' => 'vacuum', 'target_frequency' => 1, 'actual_frequency' => 0}
                            ])
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

  describe 'PUT #perform' do
    it 'increments the actual_frequency of the habit' do
      user = create_user(api_token: 'token')
      habit = create_habit(actual_frequency: 5, user_id: user.id)

      request.headers.merge!('X-AUTH-TOKEN' => user.api_token)

      put :perform, params: {id: habit.id}

      habit.reload

      expect(habit.actual_frequency).to eq 6
    end

    context 'validations' do
      it 'returns an error if the habit does not belong to the current user' do
        user = create_user_with_token
        original_actual_frequency = 3
        habit = create_habit(actual_frequency: original_actual_frequency)

        request.headers.merge!({'X-AUTH-TOKEN' => user.api_token})

        put :perform, params: {id: habit.id}

        expect(response.status).to eq 403
        expect(habit.reload.actual_frequency).to eq original_actual_frequency
      end
    end
  end
end