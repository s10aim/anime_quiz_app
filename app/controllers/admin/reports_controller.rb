class Admin::ReportsController < Admin::AdminController
  before_action :set_quiz_report, except: %i[index]

  def index
    @waiting_quiz_reports = QuizReport.lists_of('waiting')
    @pending_quiz_reports = QuizReport.lists_of('pending')
    @finished_quiz_reports = QuizReport.lists_of('finished')
  end

  def show
    @quiz = Quiz.find(@quiz_report.quiz_id)
  end

  def edit; end

  def update
    @quiz_report.update(quiz_report_params)
    flash.now[:notice] = t('notice.update_status')
  end

  private

  def set_quiz_report
    @quiz_report = QuizReport.find(params[:id])
  end

  def quiz_report_params
    params.require(:quiz_report).permit(:status)
  end
end
