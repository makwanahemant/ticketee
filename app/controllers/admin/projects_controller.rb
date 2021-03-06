class Admin::ProjectsController < Admin::ApplicationController

  def new
    @project = Project.new
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
    @project = Project.find(params[:id])

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

end

