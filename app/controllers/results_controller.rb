class ResultsController < ApplicationController
  before_action :fetch_package

  def show
    @times = (@package.finished_at - @package.start_at).to_i.divmod(60)
    @ranking = set_ranking
    @answer_count_map = Quiz.answer_count_map
    @correct_answer_count_map = Quiz.correct_answer_count_map
    @correct_choice_map = Choice.correct_choice_map
    @liked_quiz_map = Quiz.liked_count_map
  end

  private

  def set_ranking
    @categorized_package = case @package.category
                           when 'complete'
                             Package.where(category: 'complete')
                           when 'selected'
                             Package.where(anime_id: @package.anime_id)
                           end
    @categorized_package.where.not(ranking_score: nil)
                        .order(ranking_score: :desc)
                        .pluck(:ranking_score)
                        .index(@package.ranking_score) + 1
  end

  def fetch_package
    @package = if user_signed_in?
                 current_user.packages.where.not(finished_at: nil).order(created_at: :asc).last
               else
                 Package.order(created_at: :desc).find_by(guest_id: session[:guest_id])
               end
  end
end
