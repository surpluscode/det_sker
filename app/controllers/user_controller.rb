class UserController < ApplicationController
  before_action :set_user, only: [:show, :edit]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

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
  def set_user
    @user = User.find(params[:id])
  end

  def user_whitelist
    params.require(:user).permit(:email, :password, :username, :is_admin)
  end
end