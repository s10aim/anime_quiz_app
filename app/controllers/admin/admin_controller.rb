class Admin::AdminController < ApplicationController
  layout 'layouts/admin/admin'
  before_action :authenticate_admin!
end
