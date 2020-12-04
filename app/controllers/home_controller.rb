class HomeController < ApplicationController
  def index
  	@users = User.page(params[:page]).per(3)
  end
end
