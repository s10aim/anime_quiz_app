class Admin::Reports::QuizzesController < ApplicationController
  before_action :set_quiz

  def edit; end

  def update
    @quiz.update(quiz_params)
    flash.now[:notice] = t('notice.update_status')
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:id])
  end

  def quiz_params
    params.require(:quiz).permit(:status)
  end
end
