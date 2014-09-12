class WorkoutsController < ApplicationController
  before_action :set_workout, only: [:show, :edit, :update, :destroy]

  def test
    @total_mil_secs = 10000
    @exers = [{name: "first", cat: "timed", len: 15000}, {name: "second", cat: "rest", len: 10000}]
  end

  def play
    @workout = Workout.find(params[:id])
    redirect_to :back, alert: "Access Denied. You are not authorized to use this workout." if @workout.private and @workout.owner != current_user
    @exers = @workout.script
    puts "EXERCISES: #{@exers}"
  end

  # GET /workouts
  # GET /workouts.json
  def index
    @workouts = Workout.all
  end

  # GET /workouts/1
  # GET /workouts/1.json
  def show
  end

  # GET /workouts/new
  def new
    @workout = Workout.new
  end

  # GET /workouts/1/edit
  def edit
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
    puts "EXERCISE PARAMS: #{exercise_params[:exercise]}"
    ex_params = exercise_params[:exercise].map do |e|
      e[:dur] = e[:dur][:minutes].to_i*60 + e[:dur][:seconds].to_i
      e[:workout_id] = @workout.id
      e
    end
    ex_params = ex_params[0...-1]
    @exercises = @workout.exercises.create(ex_params)

    respond_to do |format|
      if @workout.save
        format.html { redirect_to @workout, notice: "Workout was successfully created" }
        format.json { render :show, status: "created", location: @workout }
      else
        format.html { render :new }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workouts/1
  # PATCH/PUT /workouts/1.json
  def update
    respond_to do |format|
      if @workout.update(workout_params)
        format.html { redirect_to @workout, notice: 'Workout was successfully updated.' }
        format.json { render :show, status: :ok, location: @workout }
      else
        format.html { render :edit }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workouts/1
  # DELETE /workouts/1.json
  def destroy
    @workout.destroy
    respond_to do |format|
      format.html { redirect_to workouts_url, notice: 'Workout was successfully destroyed.' }
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
      params.require(:workout).permit(:name)
    end

    def exercise_params
      params.permit(exercise: [:name, :cat, {dur: [:minutes, :seconds]}])
    end
end
