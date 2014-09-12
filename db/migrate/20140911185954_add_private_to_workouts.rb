class AddPrivateToWorkouts < ActiveRecord::Migration
  def change
    add_column :workouts, :private, :boolean
  end
end
