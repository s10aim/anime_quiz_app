class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:nickname]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end

  private

  def prohibit_direct_access
    redirect_to root_path if @package.nil?
  end

  def set_package
    @package = if user_signed_in?
                 current_user.packages.order(created_at: :desc).find_by(finished_at: nil)
               else
                 Package.order(created_at: :desc).find_by(guest_id: session[:guest_id], finished_at: nil)
               end
  end
end
