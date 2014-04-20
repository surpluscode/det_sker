class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit]

  def index
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
        format.html { redirect_to @event, notice: 'Event was created successfully.'}
        format.json { render action: 'show', status: :created, location: @event }
      else
        Rails.logger.info @event.errors.full_messages
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def user_params
    params.require(:event).permit(:title, :description, :creator, :category, :location, :start_time, :end_time)
  end
end
