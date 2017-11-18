class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user

    if @user.update_attributes(user_params)
      redirect_to action: :show, id: current_user.id
    else
      flash[:alert] = "Unable to update profile. #{@user.errors.full_messages.to_sentence}"
      redirect_to :edit
    end

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :biography)
  end

end
