class Admin::UsersController < ApplicationController
  before_action :admin_user

  def index
    @users = User.all.order("created_at DESC")
  end

  def new
    @users = User.new
  end

  def create
    User.create(user_params)
    if @user.save
      redirect_to admins_path
    else
      rendew :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admins_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
