class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :logout_required, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to tasks_path, notice: t('.created')
    else
      flash[:notice] = 'メールアドレスまたはパスワードに誤りがあります'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path, notice: t('.destroyed')
  end

  private

  def logout_required
    unless logged_out?
      flash[:notice] = t('common.logout_required')
      redirect_to tasks_path(current_user)
    end
  end

end
