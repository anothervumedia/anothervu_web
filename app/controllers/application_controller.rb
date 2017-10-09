class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    return root_path if resource.nil?

    feed_path
  end
end
