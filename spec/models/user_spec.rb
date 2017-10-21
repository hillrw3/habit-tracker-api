require 'rails_helper'

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
end
