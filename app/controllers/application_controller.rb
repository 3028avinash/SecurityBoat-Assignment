class ApplicationController < ActionController::Base
    # include Pagy::Backend
     before_action :require_authentication

  private

  def require_authentication
    unless session[:user_id]
      redirect_to login_path, alert: 'You must be logged in to access this page'
    end
  end
end
