class PlaysController < ApplicationController
  NUMBER_OF_QUESTIONS = 10

  before_action :fetch_package, only: %i[show]

  def create
    package = Package.new(package_params)
    package.quiz_packages = build_quiz_packages
    add_user_or_guest_id(package)
    if package.save
      session[:guest_id] = package.guest_id
      redirect_to plays_path
    else
      redirect_to description_path
    end
  end

  def show; end

  private

  def fetch_package
    @package = if user_signed_in?
                 current_user.packages.order(created_at: :desc).find_by(finished_at: nil)
               else
                 Package.order(created_at: :desc).find_by(guest_id: session[:guest_id], finished_at: nil)
               end
  end

  def build_quiz_packages
    quizzes = Quiz.published.limit(NUMBER_OF_QUESTIONS).shuffle

    quizzes.map.with_index(1) do |quiz, i|
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
    params.require(:package).permit(:category)
  end
end
