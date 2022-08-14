class Rankings::WeeksController < ApplicationController
  def show
    @week_rankings = Package.week_ranking
  end
end
