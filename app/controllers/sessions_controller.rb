# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  skip_before_action :require_authentication

  def new
    # Display the login form
  end

  def create
    user = authenticate_user(params[:username], params[:password])

    if user == 'admin'
      session[:user_id] = user
      redirect_to users_path, notice: 'Admin Logged in successfully'
    elsif user
      session[:user_id] = user.id
      redirect_to users_path, notice: 'Logged in successfully'
    else
      redirect_to login_path, alert: 'Invalid credentials'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully'
  end

  private

  def authenticate_user(username, password)
    if (username == 'admin' && password == '123')
      return 'admin'
    else
      user = User.find_by(email: username) || User.find_by(mobile_number: username)
      return user if user && user.password == password
    end
  end
end
