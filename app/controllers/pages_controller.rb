class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def home
    redirect_to feed_path if user_signed_in?
  end

  def feed
    @uploads = Upload.joins(
      "LEFT OUTER JOIN hearts ON uploads.id = hearts.upload_id AND hearts.user_id = 1")
      .select("uploads.*, hearts.id as heart_id")
      .order("uploads.created_at")
      .page(params[:page])
  end
end
