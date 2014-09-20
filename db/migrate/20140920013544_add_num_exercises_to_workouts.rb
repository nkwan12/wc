class AddNumExercisesToWorkouts < ActiveRecord::Migration
  def change
    add_column :workouts, :num_exercises, :integer
  end
end
