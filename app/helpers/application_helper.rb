module ApplicationHelper
  include SessionsHelper

  private

  def require_login
    unless logged_in?
      flash[:notice] = "ログインしてください"
      redirect_to login_path
    end
  end
end
