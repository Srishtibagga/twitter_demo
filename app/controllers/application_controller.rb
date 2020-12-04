class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?

	 protected

  def configure_permitted_parameters
    if params[:controller].include?('sessions')
      devise_parameter_sanitizer.permit(:sign_in) do |user_params|
        user_params.permit(:user_name, :email)
      end
    else
      devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
    end
  end
end
