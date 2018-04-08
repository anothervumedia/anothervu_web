class CommentsController < ApplicationController
  before_action :find_project
  before_action :find_comment, only: [:destroy, :edit, :update]

  def create
    @comment = @project.comments.create(params[:comment].permit(:content))
    @comment.user_id = current_user.id
    @comment.save

    if @comment.save
      redirect_to project_path(@project)
    else
      render 'new'
    end
  end

  def destroy
    @comment.destroy
    redirect_to project_path(@project)
  end

  def edit
  end

  def update
    if @comment.update(params[:comment].permit(:content))
      redirect_to project_path(@project)
    else
      render 'edit'
    end
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_comment
    @comment = @project.comments.find(params[:id])
  end
end
