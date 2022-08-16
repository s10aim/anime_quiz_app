class ReportsController < ApplicationController
  def create
    @quiz_report = QuizReport.new(quiz_report_params)
    if @quiz_report.save
      redirect_to results_path, notice: t('notice.create_report')
    else
      redirect_to results_path, notice: t('notice.fail_to_create')
    end
  end

  private

  def quiz_report_params
    params.require(:quiz_report).permit(:reason, :user_id, :quiz_id).merge(user_id: current_user.id,
                                                                           quiz_id: params[:quiz_report][:quiz_id])
  end
end
