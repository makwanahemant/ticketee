class Admin::UsersController < Admin::ApplicationController
  
  before_action :set_projects, only: [:new, :create, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :archive]
  
  def index
    @users = User.excluding_archived.order(:email)
  end
  
  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "User has been created."
    else
      flash.now[:alert] = "User have not been created."
      render 'new'
    end
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
    end

#    User.transaction do
#      @user.roles.clear
#      role_data = params.fetch(:roles, [])
#      role_data.each do |project_id, role_name|
#        if role_name.present?
#          @user.roles.build(project_id: project_id, role: role_name)
#        end
#      end
#    end
      
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User has been updated."
    else
      flash.now[:alert] = "User has not been updated."
      render 'edit'
      raise ActiveRecord::Rollback
    end
  end

  def archive 
    if @user == current_user 
      flash[:alert] = "You cannot archive yourself!"
    else
       @user.archive 
       flash[:notice] = "User has been archived."
    end

    redirect_to admin_users_path
  end

  private 
    def user_params
      params.require(:user).permit(:email, :password, :admin)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def set_projects
      @projects = Project.order(:name)
    end

end
