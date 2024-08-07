class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :correct_task, only: %i[show edit update destroy]

  # GET /tasks
  def index
    @search_params = task_search_params
    @tasks = current_user.tasks.search(@search_params).page(params[:page])

    @tasks = if params[:sort] == 'deadline_on'
      @tasks.sort_deadline_on
    elsif params[:sort] == 'priority'
      @tasks.sort_priority.order
    else
      @tasks.order(created_at: :desc)
    end

    # if params[:search].present?
    #   if @search_params[:title].present? && @search_params[:status].present?
    #     @tasks = @tasks.search_title(@search_params[:title]).search_status(@search_params[:status])
    #   elsif @search_params[:title].present?
    #     @tasks = @tasks.search_title(@search_params[:title])
    #   elsif @search_params[:status].present?
    #     @tasks = @tasks.search_status(@search_params[:status])
    #   elsif @search_params[:label].present?
    #     @tasks = @tasks.search_label(@search_params[:label])
    #   end
    # end


    @tasks = @tasks.page(params[:page])
  end

  # GET /tasks/1
  def show
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
    redirect_to tasks_url, notice: t('.destroyed')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:title, :content, :deadline_on, :priority, :status,label_ids: [])
  end

  def task_search_params
    params.fetch(:search, {}).permit(:title, :status, :label)
  end

  def correct_task
    @task = current_user.tasks.find_by(id: params[:id])
    redirect_to tasks_path, notice: t('common.not_privilege') if @task.nil?
  end

end
