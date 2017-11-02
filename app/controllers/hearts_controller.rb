class HeartsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:destroy]

  def create
    @heart = current_user.hearts.build(heart_params)
    if @heart.save
      # flash[:success] = "Favorited project."
    else
      flash[:alert] = @heart.errors.full_messages.to_sentence
    end

    respond_to do |format|
      format.json do
        render json: @heart
      end
    end
  end

  def destroy
    if @heart.destroy
      # flash[:success] = "Unfavorited project."
    else
      flash[:alert] = "Unable to unfavorite project."
    end

    respond_to do |format|
      format.json do
        render json: {}
      end
    end
  end

  private

  def heart_params
    params.require(:heart).permit(:project_id)
  end

  def authorize_user!
    @heart = Heart.find(params[:id])

    if @heart.user != current_user
      flash[:alert] = "Access Denied"
      redirect_to after_sign_in_path_for(current_user)
    end
  end

end
