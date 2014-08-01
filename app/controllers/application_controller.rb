class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters_for_devise, if: :devise_controller?

  include Pundit
  protect_from_forgery

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

protected
  def configure_permitted_parameters_for_devise
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

private
  def user_not_authorized
    if not current_user
      redirect_to new_user_session_path
    else
      flash[:error] = 'You are not authorized to perform this action.'
      redirect_to request.referrer || root_path
    end
  end
end
