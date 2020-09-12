class SessionsController < ApplicationController
  def new
    if current_user
      if current_merchant?
        redirect_to "/merchant"
      elsif current_admin?
        redirect_to "/admin"
      else
        redirect_to "/profile"
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
        redirect_to "/profile"
      end
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :new
    end
  end

  def destroy
  session.delete(:user_id)
  session.delete(:cart)
  flash[:success] = "You have been logged out, goodbye"
  redirect_to "/"
  end
end
