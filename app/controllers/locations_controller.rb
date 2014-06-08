class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @locations = Location.all
  end


  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_whitelist)
    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location saved successfully' }
        format.json { render action: :show, status: :created, location: @location }
      else
        format.html { render action: :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @location.update(location_whitelist)
        format.html { redirect_to @location, notice: 'Location updated successfully' }
        format.json { render action: :show, status: :created, location: @location }
      else
        format.html { render action: :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @location.destroy
    redirect_to locations_path
  end

  private
  def location_whitelist
    params.require(:location).permit(:id, :name, :street_address, :postcode, :town, :description, :latitude, :longitude)
  end

  def set_location
    @location = Location.find(params[:id])
  end

end