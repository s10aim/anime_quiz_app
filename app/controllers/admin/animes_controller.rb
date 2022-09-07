class Admin::AnimesController < Admin::AdminController
  before_action :set_anime, only: %i[edit update destroy]

  def index
    @animes = Anime.order(id: :asc)
    @anime = Anime.new
  end

  def create
    @anime = Anime.new(anime_params)

    if @anime.save
      redirect_to admin_animes_path
    else
      @animes = Anime.order(id: :asc)
      render :index, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @anime.update(anime_params)
      redirect_to admin_animes_path
    else
      render :edit, status: :unprocessable_entity
    end
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
