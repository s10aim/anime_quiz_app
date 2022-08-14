class Rankings::MonthsController < ApplicationController
  def show
    @month_rankings = Package.month_ranking
  end
end
