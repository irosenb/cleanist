class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_user

  def confirm
    ap params  
    if session[:user_id]
      @user = User.find(session[:user_id]) 
    else
      redirect_to root_path
    end
  end

  def archive
    if session[:user_id]
      @user.archive
      redirect_to root_path, notice: "your reading queue was successfully cleared!" 
    else
      redirect_to root_path
    end
  end

  private
   
    def set_user
      if session[:user_id]
        @user = User.find(session[:user_id]) 
      else
        redirect_to root_path
      end
    end
end
