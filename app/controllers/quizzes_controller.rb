class QuizzesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_quiz, only: %i[edit update destroy]

  def index
    @quizzes = current_user.quizzes.includes(:user).order(id: :desc)
  end

  def new
    @quiz = Quiz.new
  end

  def create
    current_user.quizzes.create!(quiz_params)
    redirect_to quizzes_path
  end

  def show
    @quiz = Quiz.find(params[:id])
  end

  def edit; end

  def update
    @quiz.update!(quiz_params)
    redirect_to quizzes_path
  end

  def destroy
    @quiz.destroy!
    redirect_to quizzes_path
  end

  private

  def set_quiz
    @quiz = current_user.quizzes.find(params[:id])
  end

  def quiz_params
    params.require(:quiz).permit(:question, :anime_id)
  end
end
