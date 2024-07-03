class LabelsController < ApplicationController

  def Index
    @labels = current_user.labels.all
  end
  # GET /labels/1
  def show
  end

  # GET /labels/new
  def new
    @label = current_user.labels.new
  end

  # GET /labels/1/edit
  def edit
    @tlabel = labels.find(params[:id])
  end

  # POST /labels
  def create
    @label = current_user.labels.new(label_params)

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
    @label = current_user.labels.find_by(id: params[:id])
    redirect_to labels_path, notice: t('common.not_privilege') if @label.nil?
  end
end
