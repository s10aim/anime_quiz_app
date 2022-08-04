class PlaysController < ApplicationController
  FIRST_QUESTION = 1

  before_action :fetch_package, only: %i[show]

  def show
    @quiz_package = @package.quiz_packages.find_by(position: FIRST_QUESTION)
  end

  private

  def fetch_package
    @package = if user_signed_in?
                 current_user.packages.order(created_at: :desc).find_by(finished_at: nil)
               else
                 Package.order(created_at: :desc).find_by(guest_id: session[:guest_id], finished_at: nil)
               end
  end
end
