module ApplicationHelper
  include SessionsHelper

  private

  # def require_login
  #   unless logged_in?
  #     flash[:notice] = "ログインしてください"
  #     redirect_to login_path
  #   end
  # end

  # def require_admin
  #   unless admin_user?
  #     flash[:notice] = "管理者以外アクセスできません"
  #     redirect_to user_task_path
  #   end
  # end


end
