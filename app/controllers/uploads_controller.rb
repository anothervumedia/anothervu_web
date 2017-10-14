class UploadsController < ApplicationController
  before_action :authenticate_user!

  def new
    @upload = Upload.new
  end

  def create
    @upload = current_user.uploads.build(upload_params)
    if @upload.save
      flash[:success] = "Your content was uploaded."
      redirect_to feed_path
    else
      flash[:alert] = @upload.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def upload_params
    params.require(:upload).permit(:name, :image, :image_cache, :video)
  end

end
