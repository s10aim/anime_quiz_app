class Admin::AnimesController < Admin::AdminController
  before_action :set_anime, only: %i[edit update destroy]

  def index
    @animes = Anime.published.order(id: :asc)
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
    @anime.update!(status: 'deleted')
    redirect_to admin_animes_path, status: :see_other, notice: t('notice.destroy')
  end

  private

  def set_anime
    @anime = Anime.find(params[:id])
  end

  def anime_params
    params.require(:anime).permit(:title)
  end
end
