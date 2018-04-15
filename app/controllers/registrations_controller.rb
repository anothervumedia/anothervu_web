class RegistrationsController < Devise::RegistrationsController

  def find_user
      @user = User.find(params[:id])
      authorize @user
  end

private

    # Modified Devise params for user login
    def sign_up_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :rememberable)
    end

    def after_sign_up_path_for(resource)
      edit_user_path(@user)
    end
end
