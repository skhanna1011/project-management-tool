class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def edit
    @project = Project.find(params[:id])
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def destroy
    Project.find(params[:id]).delete
    redirect_to new_project_path, flash: { success: "Submitted project successfully deleted!" }
  end

  def create
    @project = Project.new(create_params)
    if @project.save
      redirect_to project_path(@project.id), flash: { success: "New project successfully submitted!" }
    else
      render :new
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(update_params)
      redirect_to project_path(@project.id), flash: { success: "Submitted project successfully updated!" }
    else
      render :edit
    end
  end

  private

  def update_params
    @_update_params ||= params.require(:project).permit(:name, :description, :source_url)
  end

  def create_params
    @_create_params ||= update_params.merge!(user_id: current_user.id, project_demo_id: latest_demo.id)
  end

  def latest_demo
   @_latest_demo ||= ProjectDemo.where('demo_at > ?', Time.now).last
  end
end
