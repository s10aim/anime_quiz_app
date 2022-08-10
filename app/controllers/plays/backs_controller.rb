class Plays::BacksController < ApplicationController
  def update
    quiz_package = QuizPackage.find(params[:quiz_package][:id])
    back_quiz_position = quiz_package.position - 1
    @back_quiz_package = quiz_package.package.quiz_packages.find_by(position: back_quiz_position)
  end
end
