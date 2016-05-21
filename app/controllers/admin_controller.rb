class AdminController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_filter :admin_authorization

  def admin_authorization
    if current_user && !current_user.admin?
      flash[:error] = "You are not authorized to access this page"
      root_path_redirection
    end
  end
end
