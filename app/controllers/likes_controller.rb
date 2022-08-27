class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quiz

  def create
    current_user.likes.create!(quiz_id: params[:quiz_id])
    liked_quiz_map
  end

  def destroy
    current_user.likes.find_by(quiz_id: params[:quiz_id]).destroy!
    liked_quiz_map
    render :destroy, status: :see_other
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def liked_quiz_map
    @liked_quiz_map = Quiz.liked_count_map
  end
end
