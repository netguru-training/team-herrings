class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  private

  def authenticate_admin!
    user = authenticate_user!
    redirect_to root_path, error: 'Allowed only for admins' if user.admin?
  end
end
