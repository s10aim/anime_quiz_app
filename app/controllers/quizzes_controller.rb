class QuizzesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_quiz, only: %i[edit update destroy]
  before_action :set_anime, only: %i[create update]

  def index
    @quizzes = current_user.quizzes.includes(:user).order(id: :desc)
  end

  def new
    @quiz = Quiz.new
    4.times { @quiz.choices.build }
  end

  def create
    @quiz = current_user.quizzes.new(quiz_params)
    if @quiz.save
      redirect_to quizzes_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @quiz = Quiz.find(params[:id])
  end

  def edit; end

  def update
    if @quiz.update(quiz_params)
      redirect_to quiz_path(@quiz)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quiz.destroy!
    redirect_to quizzes_path, status: :see_other
  end

  private

  def set_quiz
    @quiz = current_user.quizzes.find(params[:id])
  end

  def set_anime
    @anime = Anime.find_by(id: params[:quiz][:anime])
  end

  def quiz_params
    params.require(:quiz).permit(:question, :description, :anime,
                                 choices_attributes: [:id, :body, :is_correct]).merge(anime: @anime)
  end
end
