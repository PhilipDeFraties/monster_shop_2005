class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to '/users/profile'
      flash[:success] = "Welcome #{params[:name]}, you are now registered and logged in!"
    else
      flash[:error] = "afdag"
    end
  end

  def show
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password_digest)
  end

end
