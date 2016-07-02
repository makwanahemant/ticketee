class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = policy_scope(Project)
  end

  def new
    @project = Project.new
  end

  def show
    authorize @project, :show?
  end

  def edit
    authorize @project, :update?
  end

  def create
    @project = Project.new(project_params)
    
    if @project.save
      redirect_to @project, notice: "Project has been created"
    else
      flash.now[:alert] = "Project has not been created."
      render 'new' 
    end
  end

  def update
    authorize @project, :update?

    if @project.update(project_params)
      redirect_to @project, notice: "Project has been updated."
    else
      flash.now[:alert] = "Project has not been updated." 
      render 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
  
    @project.destroy
    redirect_to projects_path, alert: "Project has been deleted."
  end
  

  private 
    def project_params
      params.require(:project).permit(:name, :description)
    end

    def set_project 
      @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The project you were looking for could not be found."
      redirect_to projects_path
    end
end
