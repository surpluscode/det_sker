class AnonymousUserController < ApplicationController
  def new
    @user = User.new
  end

  # given a username, create a one time user and allow it to create events
  def create
    allow_params_authentication!
    u = AnonymousUser.create_anonymous_user(whitelist_params)
    sign_in u
    if warden.authenticate!(scope: :user)
      warden.set_user u
      redirect_to new_event_path
    else
      redirect_to :back
    end
  end

  private
  def whitelist_params
    params.require(:user).permit(:username)
  end
end