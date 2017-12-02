class Habit < ApplicationRecord
  belongs_to :user

  validates_presence_of :title

  def unfinished?
    actual_frequency < target_frequency
  end
end