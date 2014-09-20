class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    unless current_user.admin? 
      redirect_to :back, :alert => "You are not authorized to view this page."
    end
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
      respond_to do |format|
        format.html { render "workouts/_index" }
        format.json { render json: @workouts, status: 200 }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, alert: "Access denied." }
        format.json { render json: nil, status: 401 }
      end
    end
  end

end
