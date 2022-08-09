class QuizPackagesController < ApplicationController
  before_action :set_package
  before_action :prohibit_direct_access
  before_action :set_quiz_package

  def update
    @quiz_package.update(quiz_package_params)
    next_quiz_position = @quiz_package.position + 1
    @next_quiz_package = @package.quiz_packages.find_by(position: next_quiz_position)
    last_quiz_package if @next_quiz_package.nil?
  end

  private

  def last_quiz_package
    @package.update(finished_at: Time.zone.now)
    set_quiz_result
    set_ranking_result
    redirect_to results_path
  end

  def set_quiz_result
    correct_choices = @package.quiz_packages.map do |quiz_package|
      quiz_package.choice.is_correct?
    end

    quiz_score = correct_choices.count(true)
    @package.update(quiz_score:)
  end

  def set_ranking_result
    ranking_score = (@package.quiz_score * 1000) -
                    (@package.finished_at - @package.start_at).to_i
    @package.update(ranking_score:)
  end

  def set_quiz_package
    @quiz_package = @package.quiz_packages.find(params[:id])
  end

  def quiz_package_params
    params.require(:quiz_package).permit(:choice_id)
  end
end
