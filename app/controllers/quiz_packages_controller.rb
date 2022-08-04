class QuizPackagesController < ApplicationController
  def update
    quiz_package = QuizPackage.find(params[:id])
    quiz_package.update(quiz_package_params)
    next_quiz_position = quiz_package.position + 1
    @next_quiz_package = quiz_package.package.quiz_packages.find_by(position: next_quiz_position)
  end

  private

  def quiz_package_params
    params.require(:quiz_package).permit(:choice_id)
  end
end
