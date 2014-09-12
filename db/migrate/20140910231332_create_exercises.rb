class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :cat
      t.integer :dur
      t.string :name

      t.timestamps
    end
  end
end
