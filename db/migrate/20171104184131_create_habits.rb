class CreateHabits < ActiveRecord::Migration[5.1]
  def change
    create_table :habits do |t|
      t.string :title
      t.belongs_to :user
      t.timestamps
    end
  end
end
