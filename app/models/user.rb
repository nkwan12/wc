class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :workouts
  has_many :workout_ownerships
  has_many :owned_workouts, through: :workout_ownerships, source: :workout

  private

  def generate_token
    self.token = "#{self.id}:#{SecureRandom.hex}"
    self.token_expr = DateTime.now + 60.days
    self.save
    return self.token
  end
end
