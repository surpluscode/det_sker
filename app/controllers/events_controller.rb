class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def index
    @events_by_date = Event.index
    @categories = Event.categories
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(user_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to root_path, notice: 'Event was created successfully.'}
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(user_params)
        format.html { redirect_to root_path, notice: 'Event updated successfully' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def user_params
    params.require(:event).permit(:title, :short_description, :long_description, :creator, :category, :location, :start_time, :end_time)
  end
end
