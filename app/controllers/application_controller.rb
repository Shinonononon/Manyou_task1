class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :login_required

  private

  def login_required
    unless logged_in?
      flash[:notice] = "ログインしてください"
      redirect_to new_session_path
    end
  end
end
