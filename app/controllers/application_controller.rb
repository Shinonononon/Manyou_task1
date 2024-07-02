class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :login_required


  private

  def login_required
    unless logged_in?
      flash[:notice] = t("common.login_required")
      redirect_to new_session_path
    end
  end

end
