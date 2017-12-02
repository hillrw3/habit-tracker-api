class HabitMailer < ApplicationMailer

  def reminder(email, unfinished_habits)
    @unfinished_habits = unfinished_habits
    mail(to: email, subject: 'Just a few habits left to finish!')
  end
end