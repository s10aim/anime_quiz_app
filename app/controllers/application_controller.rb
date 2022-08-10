class ApplicationController < ActionController::Base
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
