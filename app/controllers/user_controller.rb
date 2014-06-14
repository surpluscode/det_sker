class UserController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :make_admin]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :make_admin]
  before_action :authorised_user?, only: [:edit, :update, :destroy]
  before_action :admin_user?, only: :make_admin

  def index
    @users = User.all
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def make_admin
    if @user.make_admin
      redirect_to users_path, notice: "User #{@user.username} is now an admin user"
    else
      redirect_to users_path, alert: 'Error! User could not be updated...'
    end
  end

  private
  def authorised_user?
    unless current_user.can_edit? @user
      redirect_to users_path, notice: 'You are not permitted to edit this user!'
    end
  end

  def admin_user?
    unless current_user.is_admin?
      redirect_to users_path, notice: 'Only admin users can perform this action!'
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_whitelist
    params.require(:user).permit(:email, :password, :username, :is_admin)
  end
end