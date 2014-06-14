class UserController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authorised_user?, only: [:edit, :update, :destroy]

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

  private
  def authorised_user?
    unless current_user.can_edit? @user
      redirect_to users_path, notice: 'You are not permitted to edit this user!'
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_whitelist
    params.require(:user).permit(:email, :password, :username, :is_admin)
  end
end