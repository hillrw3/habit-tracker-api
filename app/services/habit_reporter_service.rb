class HabitReporterService

  def self.send_reminder
    User.all.includes(:current_habits).each do |user|
      unfinished_habits = user.current_habits.to_a.keep_if(&:unfinished?)

      HabitMailer.reminder(user.email, unfinished_habits).deliver_later
    end
  end
end