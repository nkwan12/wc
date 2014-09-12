class CreateUsersWorkouts < ActiveRecord::Migration
  def change
    create_table :users_workouts, id: false do |t|
      t.references :user
      t.references :workout
    end
  end
end
