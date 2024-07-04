class LabelsController < ApplicationController
  before_action :set_label, only: %i[show edit update destroy]
  before_action :correct_label, only: %i[show edit update destroy]

  def index
    @labels = Label.all
  end
  # GET /labels/1
  def show
  end

  # GET /labels/new
  def new
    @label = Label.new
  end

  # GET /labels/1/edit
  def edit
    @tlabel = labels.find(params[:id])
  end

  # POST /labels
  def create
    @label = Label.new(label_params)

    if @label.save
      redirect_to labels_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /labels/1
  def update
    if @label.update(label_params)
      redirect_to @label, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /labels/1
  def destroy
    @label.destroy
    redirect_to labels_url, notice: t('.destoryed')
  end

  private

  def set_label
    @label = label.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def label_params
    params.require(:label).permit(:name)
  end

  def correct_label
    @label = Label.find_by(id: params[:id])
    redirect_to labels_path, notice: t('common.not_privilege') if @label.nil?
  end
end
