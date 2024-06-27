class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.order("created_at DESC")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザーを作成しました。"
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
      redirect_to admin_users_path, notice: "ユーザー情報を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end
end
