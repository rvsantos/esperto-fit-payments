class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to new_user_session_path unless current_user.admin?
    @registrations = Registration.all
  end
end
