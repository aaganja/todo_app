class TasksController < ApplicationController
  before_action :authenticate_user!

  before_action :set_project

  def index
    @tasks = @project.tasks.where(completed_at: nil)
  end

  def show
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_tasks_path, notice: "Task was successfully created." }
      else
        format.html { redirect_to project_tasks_path, alert: @task.errors.full_messages.join(',') }
      end
    end
  end

  def update
  end

  def complete
    @task = current_user.tasks.find(params[:complete])
    @task.update(completed_at: Time.now)
  end

  def completed
    @tasks = @project.tasks.where.not(completed_at: nil)
  end

  def new
  end

  private
  def set_project
    @projects = current_user.projects
    @project = current_user.projects.find(params[:project_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :project_id, :due_date, :completed_at, :user_id)
  end
end
