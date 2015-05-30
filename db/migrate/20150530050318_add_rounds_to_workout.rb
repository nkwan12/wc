class AddRoundsToWorkout < ActiveRecord::Migration
  def change
    add_column :workouts, :rounds, :integer
  end
end
