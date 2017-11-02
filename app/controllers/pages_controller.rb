class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def home
    redirect_to feed_path if user_signed_in?
  end

  def feed
    @projects = Project.joins(
      "LEFT OUTER JOIN hearts ON projects.id = hearts.project_id AND hearts.user_id = #{current_user.id}")
      .select("projects.*, hearts.id as heart_id")
      .order("projects.created_at")
      .page(params[:page])
  end
end
