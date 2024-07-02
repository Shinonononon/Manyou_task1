class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_required

  def index
    @users = User.includes(:tasks).order("created_at DESC")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: t('admins.create.created')
    else
      render :new
    end
  end

  def show
    # set_userメソッドで@userが設定されているため、追加の処理は不要
  end

  def edit
    # set_userメソッドで@userが設定されているため、追加の処理は不要
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: t('admins.update.updated')
    # elsif @user.admin_last_one
    #   flash[:notice] = @user.errors.full_messages.join(', ')
    #   redirect_to edit_admin_user_path
    else
      # redirect_to edit_admin_user_path(@user)
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: t('admins.destroy.destroyed')
    else
      flash[:notice] = @user.errors.full_messages.join(', ')
      redirect_to admin_users_path
    end
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
    unless current_user.admin?
      flash[:notice] = t('common.admin_required')
      redirect_to tasks_path
    end
  end
end
