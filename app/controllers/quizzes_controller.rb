class QuizzesController < ApplicationController
  PER_PAGE = 10

  before_action :authenticate_user!
  before_action :set_quiz, only: %i[show edit update destroy]
  before_action :set_anime, only: %i[create update]

  def index
    @quizzes = Quiz.lists_of(current_user, 'published')
                   .includes(:anime)
                   .order(id: :desc)
                   .page(params[:page]).per(PER_PAGE)
  end

  def new
    @quiz = Quiz.new
    4.times { @quiz.choices.build }
  end

  def create
    @quiz = current_user.quizzes.new(quiz_params)
    if @quiz.save
      redirect_to quiz_path(@quiz)
    else
      set_duplicate_choice_error
      set_not_exist_correct_choice_error
      set_exist_many_correct_choices_error
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @quiz.update_with_avoiding_uniqueness_error(quiz_params)
      redirect_to quiz_path(@quiz)
    else
      set_duplicate_choice_error
      set_not_exist_correct_choice_error
      set_exist_many_correct_choices_error
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quiz.update!(status: 'deleted')
    redirect_to quizzes_path, status: :see_other, notice: t('notice.destroy')
  end

  def draft
    @quizzes = Quiz.lists_of(current_user, 'draft')
                   .includes(:anime)
                   .order(id: :desc)
                   .page(params[:page]).per(PER_PAGE)
  end

  private

  def set_duplicate_choice_error
    return unless @quiz.errors.key?(:choices)

    duplicate_choices = @quiz.choices.group_by(&:body)
                             .delete_if { |k, _v| k == '' }
                             .select { |_k, v| v.size > 1 }

    return if duplicate_choices.blank?

    duplicate_choices.values.flatten.each do |choice|
      choice.errors.add(:body, :duplicate)
    end
  end

  def set_not_exist_correct_choice_error
    return unless @quiz.errors.key?(:choices)
    return unless @quiz.choices.map(&:is_correct).count(true).zero?

    @quiz.choices.each do |choice|
      choice.errors.add(:is_correct, :not_exist)
    end
  end

  def set_exist_many_correct_choices_error
    return unless @quiz.errors.key?(:choices)
    return unless @quiz.choices.map(&:is_correct).count(true) > Quiz::CORRECT_CHOICE_LIMIT

    @quiz.choices.each do |choice|
      choice.errors.add(:is_correct, :many_exist)
    end
  end

  def set_quiz
    redirect_to quizzes_path if Quiz.find(params[:id]).deleted?

    @quiz = current_user.quizzes.find(params[:id])
  end

  def set_anime
    @anime = Anime.find_by(id: params[:quiz][:anime])
  end

  def quiz_params
    params.require(:quiz).permit(:question, :description, :status, :published_at, :anime,
                                 choices_attributes: [:id, :body, :is_correct]).merge(anime: @anime)
  end
end
