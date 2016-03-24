class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :session_location

  def session_location
    if (controller_name == "entrepreneurs" && action_name == "index")
      session[:previous_url] = request.fullpath
    end
  end
end
