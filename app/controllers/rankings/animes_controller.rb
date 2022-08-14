class Rankings::AnimesController < ApplicationController
  def show
    @anime_rankings = Package.anime_ranking
    @select_animes_collection = Anime.having_ranking_collection
  end

  def update
    @selected_anime_rankings =
      if params[:anime][:id].blank?
        Package.anime_ranking
      else
        Package.selected_anime_ranking(params[:anime][:id])
      end
  end
end
