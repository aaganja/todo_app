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
    @projects = current_user.projects
    @project = @projects.new(project_params)

    respond_to do |format|
      if !validate_due_date
        flash[:alert] = 'Task due date can not be more than three on same date.'
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      elsif @project.save
        format.html { redirect_to project_tasks_path(@project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        flash[:alert] =  @project.errors.full_messages.join(',')
        format.html { render :new }
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

    def validate_due_date
      due_date_counts = @project.tasks.group_by(&:due_date).map { |key, items| [key, items.count] }
      valid_due_date = true
      due_date_counts.each do |a|
        return unless a[1].present?
        valid_due_date = false if Task.where(due_date: a[0]).count + a[1] >= 3
      end
      valid_due_date
    end
end
