class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quiz

  def create
    current_user.likes.create!(quiz_id: params[:quiz_id])
  end

  def destroy
    current_user.likes.find_by(quiz_id: params[:quiz_id]).destroy!
    render :destroy, status: :see_other
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end
end
