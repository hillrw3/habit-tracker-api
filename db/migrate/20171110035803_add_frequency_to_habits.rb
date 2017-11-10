class AddFrequencyToHabits < ActiveRecord::Migration[5.1]
  def change
    add_column :habits, :target_frequency, :integer, default: 1
    add_column :habits, :actual_frequency, :integer, default: 0
  end
end
