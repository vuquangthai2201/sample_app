class PasswordResetsController < ApplicationController
  before_action :load_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new; end

  def create
    
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t"controllers.password_resets.email_sent"
      redirect_to root_path
    else
      flash.now[:danger] = t"controllers.password_resets.email_notfound"
      render "new"
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render "edit"
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = t"controllers.password_resets.password_reset"
      redirect_to @user
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def load_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    return if @user.activated? && @user.authenticated?(:reset, params[:id])
    redirect_to root_path
  end

  def check_expiration
    return unless @user.password_reset_expired?
      flash[:danger] = t"controllers.password_resets.password_expire"
      redirect_to new_password_reset_path
  end
end
