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
      flash[:errors] = @user.errors.full_messages.to_sentence
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
    @user = current_user
  end

  def update
    if current_user.update(user_edit_params)
      flash[:success] = "#{current_user.name}, your profile has been updated!"
      redirect_to "/profile"
    else
      flash[:errors] = current_user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def update_password
    if current_user.update(user_edit_params)
      flash[:success] = "#{current_user.name}, your password has been updated!"
      redirect_to "/profile"
    else
      flash[:errors] = "Passwords must match"
      redirect_to "/profile/edit_password"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

  def user_edit_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end
end
