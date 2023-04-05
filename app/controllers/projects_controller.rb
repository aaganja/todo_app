class ProjectsController < ApplicationController
  before_action :authenticate_user!

  # GET /projects or /projects.json
  def index
    @projects = current_user.projects
  end

  # GET /projects/new
  def new
    @projects = current_user.projects
    @project = Project.new
    @project.tasks.build
  end

  # POST /projects or /projects.json
  def create
    @project = current_user.projects.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { redirect_to projects_path, alert: @project.errors.full_messages.join(',') }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:title, tasks_attributes: [:title, :description, :due_date, :user_id])
        .tap do |wl|
          wl[:tasks_attributes].each do |hash|
            hash[1].reverse_merge!(
              user_id: current_user.id
            )
          end
        end
    end
end
