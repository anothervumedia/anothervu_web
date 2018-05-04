class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:feed, :sort_new, :terms, :privacy, :about, :contact]

  def home
    redirect_to feed_path if user_signed_in?
    @projects = Project.all.joins("INNER JOIN (#{Project.with_upload.to_sql}) as p ON p.id = projects.id").sample(12)
  end

  def feed

    if user_signed_in?
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
    else
      @projects = Project.joins(
          "INNER JOIN (#{Project.with_upload.to_sql}) as p ON p.id = projects.id")
          .order("projects.hearts_count DESC, projects.created_at DESC")
          .page(params[:page])
    end

  end

  def sort_new
    if user_signed_in?
      @projects = Project.joins(
        "LEFT OUTER JOIN hearts ON projects.id = hearts.project_id AND hearts.user_id = #{current_user.id} " +
        "INNER JOIN (#{Project.with_upload.to_sql}) as p ON p.id = projects.id")
        .select("projects.*, hearts.id as heart_id")
        .order("projects.created_at DESC")
        .page(params[:page])
    else
      @projects = Project.joins(
        "INNER JOIN (#{Project.with_upload.to_sql}) as p ON p.id = projects.id")
        .order("projects.created_at DESC")
        .page(params[:page])
    end
  end

  def liked
    if user_signed_in?
      @projects = Project.joins(
          "LEFT OUTER JOIN hearts ON projects.id = hearts.project_id AND hearts.user_id = #{current_user.id} " +
          "INNER JOIN (#{Project.with_upload.to_sql}) as p ON p.id = projects.id")
          .select("projects.*, hearts.id as heart_id").where("hearts.user_id = #{current_user.id}")
          .order("projects.hearts_count DESC, projects.created_at DESC")
          .page(params[:page])

    end
  end
end
