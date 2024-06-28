class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_required

  def index
    @users = User.all.order("created_at DESC")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: t('.created')
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    # set_userメソッドで@userが設定されているため、追加の処理は不要です
  end

  def edit
    # set_userメソッドで@userが設定されているため、追加の処理は不要です
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: t('.updated')
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: t('.destroyed')
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def admin_user
    redirect_to root_path unless admin_user?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def admin_required
    unless admin_user?
      flash[:notice] = "管理者以外アクセスできません"
      redirect_to tasks_path(current_user)
    end
  end
end
