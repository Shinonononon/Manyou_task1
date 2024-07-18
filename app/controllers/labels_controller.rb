class LabelsController < ApplicationController
  before_action :set_label, only: %i[edit update destroy]
  before_action :correct_label, only: %i[edit update destroy]

  def index
    @labels = current_user.labels.includes(:tasks).all
    # labelsで取ってるからallいらん
  end

  def show
    redirect_to labels_path
  end

  def new
    @label = current_user.labels.new
  end

  def edit
    @label = current_user.labels.find(params[:id])
  end

  def create
    @label = current_user.labels.new(label_params)

    if @label.save
      redirect_to labels_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @label.update(label_params)
      redirect_to labels_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @label.destroy
    redirect_to labels_path, notice: t('.destroyed')
  end

  private

  def set_label
    @label = Label.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:name)
  end

  def correct_label
    @label = current_user.labels.find_by(id: params[:id])
    redirect_to labels_path, notice: t('common.not_privilege') if @label.nil?
  end
end
