class Admin::TopController < ApplicationController
  before_action :authenticate_admin!
  def index; end
end
