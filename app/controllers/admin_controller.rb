class AdminController < ApplicationController

  before_action :authenticate_user!, only: [:dashboard]
  before_action :admin_user?, only: [:dashboard]

  SORT_TYPES = ['created_at', 'updated_at']

  def dashboard
    @sort = params[:sort].in?(SORT_TYPES) ? params[:sort]: 'created_at'
    @events = Event.future.order(@sort => :desc)
  end

  def series
    @expiring = EventSeries.expiring
    @expired = EventSeries.expired
  end

  def analytics
    @grouped_action = AnalyticsService.group_by(:name)
  end

  def admin_user?
    unless current_user.is_admin?
      redirect_to denied_path, notice: 'Only for admin users'
    end
  end

  def denied_path
    stored_location_for(current_user) || root_path
  end
end