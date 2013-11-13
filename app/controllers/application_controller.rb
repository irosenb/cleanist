class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def confirm 
    if session[:user_id]
      @user = User.find(session[:user_id]) 
    else
      redirect_to "/"
    end
  end

  def archive
    if session[:user_id]
      @user.archive 
    else
      redirect_to "/"
    end
  end
end
