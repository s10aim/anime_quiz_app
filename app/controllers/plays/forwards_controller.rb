class Plays::ForwardsController < ApplicationController
  def update
    quiz_package = QuizPackage.find(params[:quiz_package][:id])
    forward_quiz_position = quiz_package.position + 1
    @forward_quiz_package = quiz_package.package.quiz_packages.find_by(position: forward_quiz_position)
  end
end
