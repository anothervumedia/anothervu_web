class UploadsController < ApplicationController
  before_action :authenticate_user!

  def new
    @project = Project.find(params[:project_id])
    @upload = @project.uploads.build
  end

  def create
    @project = Project.find(params[:project_id])


      if params[:upload][:image]
        params[:upload][:image].each do |_, url|
          @project.uploads.create(image: url)
        end

        flash[:success] = "Upload successful."

        redirect_to project_path(@project)
      end


    # if @upload.save
    #   flash[:success] = "Upload successful."
    #   redirect_to project_path(@upload.project)
    # else
    #   @error = @upload.errors.full_messages.join('. ')
    #   flash[:alert] = @upload.errors.full_messages.to_sentence
    #   render :new
    # end
  end

  def destroy
    @upload = Upload.find(params[:id])
    authorize @upload

    if @upload.destroy
      redirect_to project_path(@upload.project)
      flash[:success] = "Upload was deleted."
    else
      flash[:alert] = "Unable to delete upload."
    end
  end

  private

  def upload_params
    params.require(:upload).permit(:id, :video, images: [])
  end

end
