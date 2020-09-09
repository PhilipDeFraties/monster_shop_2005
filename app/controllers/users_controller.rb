class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/users/profile'
      flash[:success] = "Welcome #{params[:name]}, you are now registered and logged in!"
    else
      flash[:error] = 'User not created, all fields must be complete'
      redirect_to '/users/new'
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password)
  end

end
