class CreateWorkoutOwnerships < ActiveRecord::Migration
  def change
    create_table :workout_ownerships do |t|
      t.references :workout, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
