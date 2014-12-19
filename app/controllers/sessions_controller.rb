class SessionsController < ApplicationController
   def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password]) && user.confirmed?
	    session[:user_id] = user.id
	    redirect_to user, notice: "Hi #{current_user.nick}! You are successfully logged in!"
  	elsif user && user.authenticate(params[:password])
      redirect_to root_url, notice: "You have to confirm your email. Please check your inbox."
    else
	    flash.now.alert = "Email or password is invalid"
	    render "new"
  	end
  end

  def destroy
  		session[:user_id] = nil
  		redirect_to root_url, notice: "Logged out correct. See you again!"
  end
end
