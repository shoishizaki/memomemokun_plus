class ApplicationController < ActionController::Base
  include SessionHelper

  def authenticate_user
    redirect_to "/login" unless login?
  end

  def no_authenticate_user
    redirect_to "/" if login?
  end

end
