class ResultsController < ApplicationController
  before_action :set_package

  def show
    @times = (@package.finished_at - @package.start_at).to_i.divmod(60)
    @ranking = set_ranking
    @answer_count_map = Quiz.answer_count_map
    @correct_answer_count_map = Quiz.correct_answer_count_map
    @correct_choice_map = Choice.correct_choice_map
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
                        .pluck(:ranking_score)
                        .sort.reverse
                        .index(@package.ranking_score) + 1
  end

  def set_package
    @package = if user_signed_in?
                 current_user.packages.order(created_at: :asc).last
               else
                 Package.order(created_at: :desc).find_by(guest_id: session[:guest_id])
               end
  end
end
