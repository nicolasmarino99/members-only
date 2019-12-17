# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[edit update index destroy]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "The user #{user.name} was deleted"
    redirect_to users_url
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = 'Welcome to Members Only!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile Updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    store_location unless logged_in?
    flash[:danger] = 'You must log in' unless logged_in?
    redirect_to sessions_new_path unless logged_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
