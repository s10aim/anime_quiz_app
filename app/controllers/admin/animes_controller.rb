class Admin::AnimesController < Admin::AdminController
  before_action :set_anime, only: %i[edit update destroy]

  def index
    @animes = Anime.order(id: :asc)
    @anime = Anime.new
  end

  def create
    Anime.create!(anime_params)
    redirect_to admin_animes_path
  end

  def edit; end

  def update
    @anime.update!(anime_params)
    redirect_to admin_animes_path
  end

  def destroy
    @anime.destroy!
    redirect_to admin_animes_path
  end

  private

  def set_anime
    @anime = Anime.find(params[:id])
  end

  def anime_params
    params.require(:anime).permit(:title)
  end
end
