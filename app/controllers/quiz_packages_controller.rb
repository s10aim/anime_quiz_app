class QuizPackagesController < ApplicationController
  before_action :set_quiz_package

  def update
    @quiz_package.update(quiz_package_params)
    next_quiz_position = @quiz_package.position + 1
    @next_quiz_package = @quiz_package.package.quiz_packages.find_by(position: next_quiz_position)
    last_quiz_package if @next_quiz_package.nil?
  end

  private

  def last_quiz_package
    @quiz_package.package.update(finished_at: Time.zone.now)
    redirect_to root_path
  end

  def set_quiz_package
    @quiz_package = QuizPackage.find(params[:id])
  end

  def quiz_package_params
    params.require(:quiz_package).permit(:choice_id)
  end
end
