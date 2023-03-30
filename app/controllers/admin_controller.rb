class AdminController < ApplicationController
  before_action :authenticate_user!

  before_action :authorize_admin

  def index
    @tasks = Task.all
  end

  private
  def authorize_admin
    unless current_user.admin?
      flash[:alert] = "You are not authorized to visit this page"
      redirect_to root_path
    end
  end
end
