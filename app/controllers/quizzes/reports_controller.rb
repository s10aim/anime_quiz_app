class Quizzes::ReportsController < ApplicationController
  before_action :set_quiz

  def new
    @quiz_report = @quiz.quiz_reports.build
  end

  def create
    @quiz_report = @quiz.quiz_reports.build(quiz_report_params)
    if @quiz_report.save
      flash.now[:notice] = t('notice.create_report')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def quiz_report_params
    params.require(:quiz_report).permit(:reason).merge(user_id: current_user.id)
  end
end
