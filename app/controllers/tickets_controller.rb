class TicketsController < ApplicationController
   
  before_action :set_project
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  
  def show
    authorize @ticket, :show?
  end

  def new
    @ticket = @project.tickets.build
    authorize @ticket, :create?
  end

  def edit
  end
  
  def create
    @ticket = @project.tickets.build(ticket_params)
    @ticket.author = current_user
    authorize @ticket, :create?

    if @ticket.save
      redirect_to [@project, @ticket], notice: "Ticket has been created."
      #redirect_to project_ticket_path(@project, @ticket), notice: "Ticket has been created."
    else
      flash.now[:alert] = "Ticket has not been created."
      render 'new'
    end
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to [@project, @ticket], notice: "Ticket has been updated."
    else
      flash.now[:alert] = "Ticket has not been updated."
      render 'edit'
    end
  end
  
  def destroy 
    @ticket.destroy

    redirect_to @project, notice: "Ticket has been deleted."
  end

  private 

    def set_ticket
      @ticket = @project.tickets.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def ticket_params
      params.require(:ticket).permit(:name, :description)
    end
end
