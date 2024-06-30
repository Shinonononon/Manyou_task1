class UsersController < ApplicationController
  before_action :correct_user, only: [:show,:update,:destroy,:edit]
  before_action :logout_required, only: [:new, :create]
  skip_before_action :login_required, only: [:new, :create]

  # skipで、applicationControllerに記入されている、login_requiredを限定的に飛ばす。

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # ユーザ登録に成功した場合の処理
      log_in(@user)
      redirect_to tasks_path, notice: t('.created')
    else
      # ユーザ登録に失敗した場合の処理
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: t('.updated')
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to new_session_path, notice: t('.destroyed')
  end
end



  #この下に書くなアホ

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to current_user unless current_user?(@user)
  end

  def logout_required
    unless logged_out?
      flash[:notice] = t('common.logout_required')
      redirect_to tasks_path(current_user)
    end
  end

end
