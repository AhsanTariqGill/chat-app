# frozen_string_literal: true

# This class handles user CRUD operations
class UsersController < ApplicationController
  before_action :authenticate_user, only: %i[become_seller edit update show index]
  before_action :correct_user, only: %i[become_seller edit update show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      if is_admin?
        redirect_to admin_root_path
      else
        redirect_to @user
      end
    else
      render :new
    end
  end

  def become_seller
    current_user.become_seller
    redirect_to current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      # Handle successful update
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def authenticate_user
    return if logged_in?

    flash[:danger] = "You'r not logged in!"
    redirect_to root_path
  end

  def correct_user
    @user_check = User.find(params[:id])
    redirect_to(root_url) unless @user_check == current_user
  end
end
