class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:home, :terms, :privacy, :about, :contact]

  def home
    redirect_to feed_path if user_signed_in?
  end

  def feed
    @projects = Project.joins(
        "LEFT OUTER JOIN hearts ON projects.id = hearts.project_id AND hearts.user_id = #{current_user.id} " +
        "INNER JOIN (#{Project.with_upload.to_sql}) as p ON p.id = projects.id")
        .select("projects.*, hearts.id as heart_id")
        .order("projects.hearts_count DESC, projects.created_at DESC")
        .page(params[:page])

      if params[:search]
        @projects = @projects.search(params[:search])
      else
        @projects
      end
  end
end
