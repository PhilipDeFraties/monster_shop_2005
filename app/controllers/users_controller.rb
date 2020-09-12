class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{user_params["name"]}, you are now registered and logged in!"
      redirect_to '/profile'
    else
      flash[:errors] = @user.errors.full_messages
      if @user.errors.details.keys.include?(:email)
        @user.email = ""
      end
      render :new
    end
  end

  def show
    unless current_user != nil
      render file: "/public/404"
    end
  end

  def edit
  end 

  private
  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password)
  end

end
