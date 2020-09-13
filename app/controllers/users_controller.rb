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
    @user = User.find(params[:user_id])
  end

  def update
    @user = User.find(params[:user_id])
    @user.update(user_edit_params)

    if @user.save
      flash[:success] = "#{user_edit_params["name"]}, your profile has been updated!"
      redirect_to "/profile"
    else
      flash[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  # def editpassword
  #   @user = User.find(params[:id])
  # end
  #update_password
  def update_password
    @user = User.find(params[:user_id])
    @user.update(user_password_params)
    binding.pry
    if @user.save
      flash[:success] = "#{current_user.name}, your password has been updated!"
      redirect_to "/"
    else
      flash[:errors] = "Passwords must match"
      render :edit
    end
  end



  private
  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password)
  end

  def user_edit_params
    params.permit(:name, :address, :city, :state, :zip, :email)
  end

  def user_password_params
    params.permit(:password)
  end

end
