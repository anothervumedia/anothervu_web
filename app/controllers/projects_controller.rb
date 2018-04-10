class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_user.projects
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      flash[:success] = "Your project was created. Now add some images."
      redirect_to project_path(@project)
    else
      flash[:alert] = @project.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
    @creator = @project.user
    @heart = @project.hearts.where(user: current_user).first
    @uploads = @project.uploads
    @comments = Comment.where(project_id: @project).order("created_at DESC")
  end

  def edit
    @project = Project.find(params[:id])
    authorize @project
  end

  def update
    @project = Project.find(params[:id])
    authorize @project

    if @project.update_attributes(project_params)
      redirect_to projects_path, notice: "#{@project.name} updated."
    else
      flash[:alert] = "Unable to update project. #{@project.errors.full_messages.to_sentence}"
      redirect_to :edit
    end

  end

  def destroy
    @project = Project.find(params[:id])
    authorize @project

    if @project.destroy
      redirect_to projects_path, notice: "Project deleted."
    else
      redirect_to projects_path, alert: "Unable to delete project."
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :location, :category)
  end

end
