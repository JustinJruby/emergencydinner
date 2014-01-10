class SafeCookingTempsController < ApplicationController
  before_action :set_safe_cooking_temp, only: [:show, :edit, :update, :destroy]

  # GET /safe_cooking_temps
  # GET /safe_cooking_temps.json
  def index
    @safe_cooking_temps = SafeCookingTemp.all
  end

  # GET /safe_cooking_temps/1
  # GET /safe_cooking_temps/1.json
  def show
  end

  # GET /safe_cooking_temps/new
  def new
    @safe_cooking_temp = SafeCookingTemp.new
  end

  # GET /safe_cooking_temps/1/edit
  def edit
  end

  # POST /safe_cooking_temps
  # POST /safe_cooking_temps.json
  def create
    @safe_cooking_temp = SafeCookingTemp.new(safe_cooking_temp_params)

    respond_to do |format|
      if @safe_cooking_temp.save
        format.html { redirect_to @safe_cooking_temp, notice: 'Safe cooking temp was successfully created.' }
        format.json { render action: 'show', status: :created, location: @safe_cooking_temp }
      else
        format.html { render action: 'new' }
        format.json { render json: @safe_cooking_temp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /safe_cooking_temps/1
  # PATCH/PUT /safe_cooking_temps/1.json
  def update
    respond_to do |format|
      if @safe_cooking_temp.update(safe_cooking_temp_params)
        format.html { redirect_to @safe_cooking_temp, notice: 'Safe cooking temp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @safe_cooking_temp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /safe_cooking_temps/1
  # DELETE /safe_cooking_temps/1.json
  def destroy
    @safe_cooking_temp.destroy
    respond_to do |format|
      format.html { redirect_to safe_cooking_temps_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_safe_cooking_temp
      @safe_cooking_temp = SafeCookingTemp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def safe_cooking_temp_params
      params.require(:safe_cooking_temp).permit(:group, :meat_type, :temp, :note)
    end
end
