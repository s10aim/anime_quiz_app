class DescriptionsController < ApplicationController
  NUMBER_OF_QUESTIONS = 10

  def show
    @package = Package.new(category: params[:category])
    @select_animes_collection = Anime.having_quiz_collection
  end

  def create
    @package = Package.new(package_params)
    @package.quiz_packages = build_quiz_packages
    add_user_or_guest_id(@package)
    if @package.save
      session[:guest_id] = @package.guest_id
      redirect_to plays_path
    else
      @select_animes_collection = Anime.having_quiz_collection
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_quizzes
    case params[:package][:category]
    when 'complete'
      Quiz.published.order('RANDOM()').limit(NUMBER_OF_QUESTIONS)
    when 'selected'
      Quiz.published
          .where(anime_id: params[:package][:anime_id])
          .order('RANDOM()')
          .limit(NUMBER_OF_QUESTIONS)
    end
  end

  def build_quiz_packages
    set_quizzes.map.with_index(1) do |quiz, i|
      QuizPackage.new(position: i, quiz_id: quiz.id)
    end
  end

  def add_user_or_guest_id(package)
    if user_signed_in?
      package.user_id = current_user.id
    else
      package.guest_id = SecureRandom.uuid
    end
  end

  def package_params
    params.require(:package).permit(:category, :anime_id)
  end
end
