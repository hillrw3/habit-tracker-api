require 'rails_helper'

describe HabitReporterService do
  describe '.sendreminder' do
    it 'sends an email with a list of unfinished habits for the current week' do
      user = create_user(email: 'bill@blah.com')
      finished_habit = create_habit(title: 'look how finished i am', user_id: user.id, target_frequency: 1, actual_frequency: 1)
      unfinished_habit = create_habit(title: 'man, im unfinished', user_id: user.id, target_frequency: 3, actual_frequency: 1)
      old_unfinished_habit = create_habit(title: 'man, im unfinished AND old', user_id: user.id, created_at: 1.month.ago)

      expect { HabitReporterService.send_reminder }.to change { ActionMailer::Base.deliveries.count }.by(1)

      email = ActionMailer::Base.deliveries.last

      expect(email.body).to include "1/3 #{unfinished_habit.title}"
      expect(email.body).not_to include finished_habit.title
      expect(email.body).not_to include old_unfinished_habit.title
    end
  end
end