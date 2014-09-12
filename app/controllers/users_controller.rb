class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

  def workouts
    @user = User.find(params[:id])
    if @user == current_user
      @workouts = @user.workouts
      render "workouts/_index"
    else
      redirect_to :back, alert: "Access denied."
    end
  end

end
