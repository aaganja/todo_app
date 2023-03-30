class TasksController < ApplicationController
  before_action :authenticate_user!

  before_action :set_project

  def index
    @tasks = @project.tasks
  end

  def create
  end

  def update
  end

  def new
  end

  private
  def set_project
    @projects = current_user.projects
    @project = current_user.projects.find(params[:project_id])
  end
end
