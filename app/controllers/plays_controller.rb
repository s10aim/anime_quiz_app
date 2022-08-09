class PlaysController < ApplicationController
  FIRST_QUESTION = 1

  before_action :set_package
  before_action :prohibit_direct_access

  def show
    @quiz_package = @package.quiz_packages.find_by(position: FIRST_QUESTION)
  end
end
