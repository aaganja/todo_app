class TasksController < ApplicationController
  before_action :authenticate_user!

  before_action :set_project

  def index
    @tasks = @project.tasks.where(completed_at: nil)
  end

  def create
  end

  def update
  end

  def complete
    @task = current_user.tasks.find(params[:complete])
    @task.update(completed_at: Time.now)
  end

  def new
  end

  private
  def set_project
    @projects = current_user.projects
    @project = current_user.projects.find(params[:project_id])
  end

end
