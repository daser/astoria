class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user #make this method available in views

  def current_user
 # 	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  	@current_user ||= session[:user_id] && User.find_by_id(session[:user_id]) # Use find_by_id to get nil instead of an error if user doesn't exist

  end

    
	def save_login_state!
  		if session[:user_id]
  			redirect_to "/home"
  			return false
  		else
  			return true
  		end
 	end

end
