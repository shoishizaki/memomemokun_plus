class SessionController < ApplicationController
  before_action :no_authenticate_user

  def new
  end
end
