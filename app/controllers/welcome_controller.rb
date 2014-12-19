class WelcomeController < ApplicationController
  def home
  	@orders = Order.where("state_id == ?", cookies[:state_id]).last(5)
  end
end
