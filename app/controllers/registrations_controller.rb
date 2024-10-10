class RegistrationsController < ApplicationController
  allow_unauthenticated_access

  def new
    @account = User::Account.new
  end

  def create
    @account = User::Account.new(user_params)
    if @account.save
      start_new_session_for @account
      redirect_to root_path, notice: 'Successfully signed up!'
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user_account).permit(:email_address, :password, :password_confirmation)
  end
end