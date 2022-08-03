class QuizPackagesController < ApplicationController
  def update
    quiz_package = QuizPackage.find(params[:id])
    quiz_package.update(quiz_package_params)
  end

  private

  def quiz_package_params
    params.require(:quiz_package).permit(:choice_id)
  end
end
