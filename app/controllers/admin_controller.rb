class AdminController < ApplicationController
  before_action :authenticate_user!

  before_action :authorize_admin

  def index
    @tasks = Task.all
  end

  private
  def authorize_admin
    flash[:alert] = "You are not authorized to visit this page"
    redirect_to root_path unless current_user.admin?
  end
end
