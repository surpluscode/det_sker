class EventSeriesController < ApplicationController
  before_action :set_event_series, only: [:show, :edit, :update, :destroy]
  #TODO: shouldn't we authenticate the user before the create action also?
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :authorised_user?, only: [:edit, :update, :destroy]

  def index
    @event_series = EventSeries.all
  end

  def show
  end

  def new
    @event_series = EventSeries.new
  end

  def create
    event_params = user_params
    # add the user id if we've got one
    event_params.merge!(user_id: current_user.id) if user_signed_in?
    
    @event_series = EventSeries.new(event_params)
    respond_to do |format|
      if @event_series.save
        format.html {
         render action: 'show', notice: I18n.t('events.event_created', name: @event_series.name, id: @event_series.id)
        }
        format.json { render action: 'show', status: :created, location: @event_series }
      else
        format.html { render action: 'new' }
        format.json { render json: @event_series.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event_series.update(user_params)
        destroy_image?
        format.html { render action: 'show', notice: I18n.t('events.event_created', name: @event_series.name, id: @event_series.id) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event_series.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def destroy
    @event_series.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private

  def set_event_series
    @event_series = EventSeries.find(params[:id])
  end

  def authorised_user?
    unless current_user.can_edit? @event_series
      redirect_to root_path, alert: I18n.t('general.permission_denied')
    end
  end

  # if the obj has a picture but it's not in the new form
  def destroy_image?
    if @event_series.picture.present? && params[:remove_picture] == '1'
      @event_series.picture.clear
      @event_series.save
    end
  end

  def user_params
    params.require(:event_series).permit(:title, :description, :location_id, :comments_enabled,
                                 :price, :cancelled, :link, :picture, :rule, :start_date, 
                                 :start_time, :expiry, :end_time, day_array: [], 
                                 category_ids: []).tap do |list|
      list[:category_ids].uniq!
      list[:days] = list[:day_array].select(&:present?).join(',')
    end
  end
end
