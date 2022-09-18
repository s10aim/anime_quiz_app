class HomeController < ApplicationController
  before_action :authenticate_user!
  def show
    @complete_best_ranking = Package.complete_best_ranking(current_user) || '**'
    @selected_best_ranking = Package.selected_best_ranking(current_user) || '**'
  end
end
