class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

   def logged_in_user
  	if not logged_in?
  		store_location
  		flash[:danger] = "ログインしてください"
  		redirect_to login_url
  	end
  end

  def correct_user
     @user = User.find(params[:id])
     redirect_to(root_url) unless current_user?(@user)
  end

end
