class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(resource)
    return root_path if resource.nil?

    feed_path
  end

  def default_url_options
    { host: ENV['HOST'] || 'localhost:3000' }
  end
  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || feed_path)
  end
end
