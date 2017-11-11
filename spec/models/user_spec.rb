require 'rails_helper'
require_relative '../../lib/calendar'

describe User do
  describe '.authenticate' do
    context 'when the credentials match an existing user' do
      it 'returns a token that has been saved to the user' do
        user = create_user({username: 'bill', password: 'password'})

        returned_token = User.authenticate('bill', 'password')
        user.reload

        expect(returned_token).to eq user.api_token
      end
    end

    context 'when the credentials do NOT match an existing user' do
      it 'returns nothing' do
        expect(User.authenticate('', '')).to be_falsey
      end
    end
  end

  describe '#current_habits' do
    it 'returns habits created in the current week' do
      allow(Calendar).to receive(:beginning_of_week) { 3.days.ago.to_date }

      user = create_user
      current_habit = create_habit(created_at: [1,2,3].sample.days.ago, user_id: user.id)
      old_habit = create_habit(created_at: 5.days.ago, user_id: user.id)

      current_habits = user.current_habits
      expect(current_habits).to include(current_habit)
      expect(current_habits).not_to include(old_habit)
    end
  end
end
