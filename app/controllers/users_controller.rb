class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{user_params["name"]}, you are now registered and logged in!"
      render :show
    else
      flash[:errors] = @user.errors.full_messages
      if @user.errors.details.keys.include?(:email)
        @user.email = ""
      end
      render :new
    end
  end

  def show
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      render file: "/public/404"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password)
  end

end
