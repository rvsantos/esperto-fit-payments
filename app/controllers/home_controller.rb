class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :auth_admin

  def index
    @registrations = Registration.all
  end

  private

  def auth_admin
    redirect_to new_user_session_path unless current_user.admin?
  end
end
