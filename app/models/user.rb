class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :workouts
  has_many :workout_ownerships
  has_many :owned_workouts, through: :workout_ownerships, source: :workout
end
