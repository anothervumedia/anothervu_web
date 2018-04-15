class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user
  before_action :capitalize
  # devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :confirmable, :validatable

  def show
    respond_to do |format|
        format.html # show.html.erb
        format.js # show.js.erb
        format.json { render json: @user }
    end
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    if @user.update_attributes(user_params)
      redirect_to action: :show, id: current_user.id
    else
      flash[:alert] = "Unable to update profile. #{@user.errors.full_messages.to_sentence}"
      redirect_to :edit
    end

  end

  def capitalize
    if !@user.first_name.nil?
      @user.first_name = @user.first_name.capitalize
    end
    if !@user.last_name.nil?
      @user.last_name = @user.last_name.capitalize
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :biography, :phone_number, :website, :email_show)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
