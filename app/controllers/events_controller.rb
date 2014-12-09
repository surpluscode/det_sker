class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  #TODO: shouldn't we authenticate the user before the create action also?
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :authorised_user?, only: [:edit, :update, :destroy]

  def show
  end

  def new
    @event = Event.new
  end

  def create
    event_params = user_params
    # add the user id if we've got one
    event_params.merge!(user_id: current_user.id) if user_signed_in?

    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to root_path, notice: I18n.t('events.event_created')}
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
        format.html { redirect_to root_path, notice: I18n.t('events.event_updated')}
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

  def authorised_user?
    unless current_user.can_edit? @event
      redirect_to root_path, alert: I18n.t('general.permission_denied')
    end
  end

  def user_params
    params.require(:event).permit(:title, :short_description, :long_description,
                                 :start_time, :end_time,  :location_id, :comments_enabled,
                                 :price, :cancelled, category_ids: []).tap do |list|
      list[:category_ids].uniq!
    end
  end
end
