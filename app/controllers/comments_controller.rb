class CommentsController < ApplicationController
  before_action :find_project

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

  private

  def find_project
    @project = Project.find(params[:project_id])
  end
end
