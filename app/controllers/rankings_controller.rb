class RankingsController < ApplicationController
  def show
    return if current_user.nil?

    @my_best_score_of_complete = Package.my_best_score_of(current_user, 'complete')
    @my_best_score_of_selected = Package.my_best_score_of(current_user, 'selected')
  end
end
