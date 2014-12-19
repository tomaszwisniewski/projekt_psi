class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_categories, :set_states, :set_state
	

	def set_categories
	  @categories = Category.order('name ASC')
	end

	def set_states
	  @states = State.order('name ASC')
	end

	def set_state
			cookies[:state_id] = State.first.id if cookies[:state_id] == nil
	end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

 
  private

		def current_user
		  @current_user ||= User.find(session[:user_id]) if session[:user_id]
		end

		def first_category
			@category = Category.order('name ASC').first
		end

		def current_state
			@state = State.find_by_id(cookies[:state_id])
		end
		helper_method :current_user, :first_category, :current_state
end
