class ApplicationController < ActionController::Base
  
  before_action :configure_permitted_parameters, :if => :devise_controller?
    
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.  
  protect_from_forgery with: :exception
  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end  

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :name, :password, :password_confirmation)
    end
  end
    
  private

  def authenticate_admin!
    user = authenticate_user!
    redirect_to root_path, error: 'Allowed only for admins' unless user.admin?
  end
end
