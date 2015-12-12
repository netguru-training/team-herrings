class AdminController < ApplicationController
  before_action :authenticate_admin!

  def dashboard

  end

  private

  def authenticate_admin!
    user = authenticate_user!
    unless user.is_admin?
      flash[:error] = 'Allowed only for admins'
      redirect_to root_path
    end
  end
end
