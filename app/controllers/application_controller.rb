class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :login_required

  # rescue_from StandardError, with: :render500
  rescue_from ActiveRecord::RecordNotFound, with: :render404

  # def render500(error = nil)
  #   Rails.logger.error("❌#{error.message}") if error
  #   render template: 'errors/error500.html', layout: 'error', status: :internal_server_error
  # end
  def render404(error = nil)
    Rails.logger.error("❌#{error.message}") if error
    render template: 'errors/error404.html', layout: 'error', status: :not_found
  end

  private

  def login_required
    unless logged_in?
      flash[:notice] = t("common.login_required")
      redirect_to new_session_path
    end
  end

end
