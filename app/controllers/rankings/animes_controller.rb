class Rankings::AnimesController < ApplicationController
  RANKING_LIMIT = 10

  def show
    @anime_rankings = Package.anime_ranking.limit(RANKING_LIMIT)
    @select_animes_collection = Anime.having_ranking_collection
  end

  def update
    @selected_anime_rankings =
      if params[:anime][:id].blank?
        Package.anime_ranking.limit(RANKING_LIMIT)
      else
        Package.selected_anime_ranking(params[:anime][:id])
      end
  end
end
