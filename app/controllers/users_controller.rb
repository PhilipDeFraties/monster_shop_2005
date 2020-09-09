class UsersController < ApplicationController

  def new
  end

  def create
    redirect_to '/profile'
    flash[:success] = 'Welcome Jeff Bezos, you are now registered and logged in!'
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

end
