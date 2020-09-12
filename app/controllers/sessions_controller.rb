class SessionsController < ApplicationController
  def new
    if session[:user_id] != nil
      if current_user.role == "default"
        redirect_to "/profile"
      elsif current_user.role == "merchant"
        redirect_to "/merchant"
      elsif current_user.role == "admin"
        redirect_to "/admin"
      end
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}, you are logged in!"
      if current_merchant?
        redirect_to "/merchant"
      elsif current_admin?
        redirect_to "/admin"
      else
        redirect_to "/users/#{user.id}"
      end
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :new
    end
  end

  def destroy
  session.delete(:user_id)
  session.delete(:cart)
  redirect_to "/"
  flash[:success] = "You have been logged out, goodbye"
  end
end
