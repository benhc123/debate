class ThesesController < ApplicationController
  before_action :set_thesis, only: [:show, :edit, :update, :destroy, :revert]

  # GET /theses
  # GET /theses.json
  def index
    @theses = Thesis.all
  end

  # GET /theses/1
  # GET /theses/1.json
  def show
  end

  # GET /theses/new
  def new
    @thesis = Thesis.new
    @thesis.issue = Issue.find params[:issue] if params[:issue]
    @thesis.position = params[:position] if params[:position]

    authorize @thesis
  end

  # GET /theses/1/edit
  def edit
  end

  # POST /theses
  # POST /theses.json
  def create
    @thesis = Thesis.new(thesis_params)

    @thesis.author = current_user

    respond_to do |format|
      if @thesis.save
        format.html { redirect_to @thesis.issue, notice: 'Thesis was successfully created.' }
        format.json { render :show, status: :created, location: @thesis }
      else
        format.html { render :new }
        format.json { render json: @thesis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /theses/1
  # PATCH/PUT /theses/1.json
  def update
    authorize @thesis

    respond_to do |format|
      if @thesis.update(thesis_params)
        format.html { redirect_to @thesis.issue, notice: 'Thesis was successfully updated.' }
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
      params.require(:thesis).permit(:issue_id, :summary, :text, :author_id, :position)
    end
end
