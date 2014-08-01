class ThesesController < ApplicationController
  before_action :set_thesis, only: [:show, :edit, :update, :revert, :remove]
  before_action :set_issue, only: [:new, :create, :update, :revert, :remove]

  def show
  end

  def new
    @position = params[:position]
    @thesis = Thesis.new
    authorize @thesis
  end

  def create
    service = CreateThesisRelatedToIssue.new(thesis_params.merge(author: current_user), @issue, params[:position])
    service.run
    @thesis = service.thesis

    respond_to do |format|
      if service.success?
        format.html { redirect_to @issue, notice: 'Thesis was successfully created.' }
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

  def revert
    version_number = params[:thesis][:version].to_i
    already_at_desired_version = version_number == @thesis.versions.last.index
    no_version_to_switch_to = @thesis.versions.count < 2
    return redirect_to @issue if already_at_desired_version or no_version_to_switch_to

    @thesis.revert_to!(version_number, @issue)
    redirect_to @issue
  end

  def remove
    respond_to do |format|
      if @issue.remove_thesis(@thesis)
        format.js
      end
    end
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_thesis
      @thesis = Thesis.find(params[:id])
    end

    def set_issue
      @issue = Issue.find(params[:issue_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def thesis_params
      params.require(:thesis).permit(:summary, :text, :author_id)
    end
end
