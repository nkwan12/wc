class Workout < ActiveRecord::Base
  before_save :count_exercises
  has_many :exercises
  has_and_belongs_to_many :users
  has_one :workout_ownership
  has_one :owner, through: :workout_ownership, source: :user 

  def script
    return self.exercises.map {|e| e.to_json.html_safe}
  end

  def count_exercises
    self.num_exercises = self.exercises.length
  end

end
