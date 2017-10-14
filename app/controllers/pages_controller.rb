class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def home
    redirect_to feed_path if user_signed_in?
  end

  def feed
    @uploads = Upload.all.page params[:page]
  end
end
