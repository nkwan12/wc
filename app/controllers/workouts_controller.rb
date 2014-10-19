class WorkoutsController < ApplicationController
  before_action :set_workout, only: [:show, :edit, :update, :destroy]

  def play
    @workout = Workout.find(params[:id])
    redirect_to :back, alert: "Access Denied. You are not authorized to use this workout." if @workout.private and @workout.owner != current_user
    @exers = @workout.exercises.select("cat, dur, name")
  end

  # GET /workouts
  # GET /workouts.json
  def index
    unless current_user and current_user.admin? 
      redirect_to "/", :alert => "Access Denied."
    end
    @workouts = Workout.all
  end

  # GET /workouts/1
  # GET /workouts/1.json
  def show
    if @workout.private and @workout.owner != current_user
      redirect_to :back, alert: "Private workout, access denied."
    end

    respond_to do |format|
      format.json { render json: {workout: @workout, exercises: @workout.exercises.select("id, name, dur, cat")}, status: 200 }
      format.html
    end
  end

  # GET /workouts/new
  def new
    @workout = Workout.new
  end

  # GET /workouts/1/edit
  def edit
    @workout = Workout.find(params[:id])
    unless @workout.owner == current_user or @workout.owner == temp_user
      redirect_to :back, :alert => "Only the workout owner may edit this workout."
    end
  end

  # POST /workouts
  # POST /workouts.json
  def create
    @workout = Workout.new(workout_params)
    if user_signed_in?
      @workout.owner = current_user
      @workout.users << current_user
    else
      @workout.owner = temp_user
      session[:workout_id] = @workout.id
    end 
    @workout.save
    ex_params = exercise_params[:exercise].map do |e|
      e[:dur] = e[:dur][:minutes].to_i*60 + e[:dur][:seconds].to_i
      e[:workout_id] = @workout.id
      e
    end
    @exercises = @workout.exercises.create(ex_params)

    respond_to do |format|
      if @workout.save
        format.html { redirect_to @workout, notice: "Workout was successfully created" }
        format.json { render json: {workoutId: @workout.id}, status: 200 }
      else
        format.html { render :new }
        format.json { render json: @workout.errors, status: 500 }
      end
    end
  end

  # PATCH/PUT /workouts/1
  # PATCH/PUT /workouts/1.json
  def update
    owner = @workout.owner
    unless owner == current_user or owner == temp_user
      redirect_to "/", alert: "Permission Denied."
    end
    @workout.update(workout_params)
    @workout.exercises.destroy_all

    ex_params = exercise_params[:exercise].map do |e|
      e[:dur] = e[:dur][:minutes].to_i*60 + e[:dur][:seconds].to_i
      e[:workout_id] = @workout.id
      e
    end
    @exercises = @workout.exercises.create(ex_params)
    
    respond_to do |format|
      if @workout.save
        format.html { redirect_to @workout, notice: 'Workout was successfully updated.' }
        format.json { render json: {workoutId: @workout.id}, status: 200 }
      else
        format.html { render :edit }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workouts/1
  # DELETE /workouts/1.json
  def destroy
    owner = @workout.owner
    unless current_user and (owner == current_user or current_user.admin?)
      redirect_to "/", alert: "Permission Denied."
    end
    @workout.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Workout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout
      @workout = Workout.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workout_params
      params.require(:workout).permit(:name, :private)
    end

    def exercise_params
      params.permit(exercise: [:name, :cat, {dur: [:minutes, :seconds]}])
    end
end
