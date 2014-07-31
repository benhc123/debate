class ThesesController < ApplicationController
  before_action :set_thesis, only: [:show, :edit, :update, :destroy, :revert]

  def show
  end

  def new
    @issue = Issue.find(params[:issue_id])
    @position = params[:position]
    @thesis = Thesis.new
    authorize @thesis
  end

  def create
    issue = Issue.find(params[:issue_id])
    service = CreateThesisRelatedToIssue.new(thesis_params.merge(author: current_user), issue, params[:position])
    service.run
    @thesis = service.thesis

    respond_to do |format|
      if service.success?
        format.html { redirect_to issue, notice: 'Thesis was successfully created.' }
        format.json { render :show, status: :created, location: @thesis }
      else
        format.html { render :new }
        format.json { render json: @thesis.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    authorize @thesis
    @issue = Issue.find(params[:issue_id])
    service = UpdateThesis.new(@thesis, thesis_params, @issue)
    service.run

    respond_to do |format|
      if service.success?
        format.html { redirect_to @issue, notice: 'Thesis was successfully updated.' }
        format.json { render :show, status: :ok, location: @thesis }
      else
        format.html { render :edit }
        format.json { render json: @thesis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /theses/1
  # DELETE /theses/1.json
  def destroy
    @thesis.destroy
    respond_to do |format|
      format.html { redirect_to theses_url, notice: 'Thesis was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def revert
    version_number = params[:thesis][:version].to_i
    already_at_desired_version = version_number == @thesis.versions.last.index
    no_version_to_switch_to = @thesis.versions.count < 2
    return redirect_to @thesis.issue if already_at_desired_version or no_version_to_switch_to

    reified = @thesis.versions[version_number].next.reify
    reified.save
    redirect_to @thesis.issue
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_thesis
      @thesis = Thesis.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def thesis_params
      params.require(:thesis).permit(:summary, :text, :author_id)
    end
end
