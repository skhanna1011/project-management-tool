# require_dependency "app/decorators/project_demo_decorator"

class ProjectDemosController < ApplicationController
  def index
  end

  def edit
    if current_user.admin?
      @project_demo = ProjectDemo.find(params[:id])
    else 
       redirect_to root_path, flash: { info: "Project demo schedule can only be updated by admins" }
    end
  end

  def show
    @project_demo = ProjectDemo.find(params[:id])
  end

  def latest
    @project_demo = upcoming_demo
    @projects = @project_demo.projects
  end

  def new
    if current_user.admin?
      @project_demo = ProjectDemo.new
    else 
       redirect_to root_path, flash: { info: "Project demos can only be scheduled by admins" }
    end
  end

  def destroy
    ProjectDemo.find(params[:id]).delete
    redirect_to new_project_demo_path, flash: { success: "Project schedule successfully deleted!" }
  end

  def create
    @project_demo = ProjectDemo.new(create_params)
    if @project_demo.save
      redirect_to project_demo_path(@project_demo.id), flash: { success: "Project schedule successfully created!" }
    else
      render :new
    end
  end

  def update
    @project_demo = ProjectDemo.find(params[:id])
    if @project_demo.update_attributes(update_params)
      redirect_to project_demo_path(@project_demo.id), flash: { success: "Project schedule successfully updated!" }
    else
      render :edit
    end
  end

  private

  def update_params
    @_update_params ||= params.require(:project_demo).permit(:name, :description, :demo_at, :window_closes_at)
  end

  def create_params
    @_create_params ||= update_params.merge!(status: 'open', window_opens_at: Time.now, month: Date.today.strftime("%B"))
  end

  def upcoming_demo
    @_upcoming_demo ||= params[:project_id] ? ProjectDemo.find(params[:id]) : ProjectDemo.where('demo_at > ?', Time.now).last
  end

end
