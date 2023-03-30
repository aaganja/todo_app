class AdminController < ApplicationController
  before_action :authenticate_user!

  before_action :authorize_admin

  def index
    @projects = Project.all
  end

  def task
    @project = Project.find(params[:id])
    @tasks = @project.tasks
  end

  private
  def authorize_admin
    unless current_user.admin?
      flash[:alert] = "You are not authorized to visit this page"
      redirect_to root_path
    end
  end
end
