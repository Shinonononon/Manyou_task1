class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks
  def index
    @search_params = task_search_params
    @tasks = current_user.tasks.search(@search_params).page(params[:page])

    @tasks = if params[:sort] == 'deadline_on'
      @tasks.sort_deadline_on
    elsif params[:sort] == 'priority'
      @tasks.sort_priority.order(created_at: :desc)
    else
      @tasks.order(created_at: :desc)
    end

    @tasks = @tasks.page(params[:page])
  end

  # def index
  #   @tasks = Task.all.page(params[:page])
  #   #タスク検索機能
  #   @search_params = task_search_params
  #   @tasks = Task.search(@search_params)

  #   if params[:sort_deadline_on]
  #     @tasks = Task.sort_deadline_on.page(params[:page])
  #   elsif params[:sort_priority]
  #     @tasks = Task.sort_priority.page(params[:page])
  #   else
  #     @tasks = Task.order(created_at: :desc).page(params[:page])
  #   end
  # end

  # GET /tasks/1
  def show
    @task = current_user.tasks.find(params[:id])
  end

  # GET /tasks/new
  def new
    @task = current_user.tasks.new
  end

  # GET /tasks/1/edit
  def edit
    @task = current_user.tasks.find(params[:id])
  end

  # POST /tasks
  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to @task, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: t('.destoryed')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = current_user.task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:title, :content, :deadline_on, :priority, :status)
  end

  def task_search_params
    params.fetch(:search, {}).permit(:title, :status)
  end
end
