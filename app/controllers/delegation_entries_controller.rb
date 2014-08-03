class DelegationEntriesController < ApplicationController
  before_action :set_delegation_entry, only: [:show, :edit, :update, :destroy]

  # GET /delegation_entries
  # GET /delegation_entries.json
  def index
    @delegation_entries = DelegationEntry.all
  end

  # GET /delegation_entries/1
  # GET /delegation_entries/1.json
  def show
  end

  # GET /delegation_entries/new
  def new
    @delegation_entry = DelegationEntry.new
  end

  # GET /delegation_entries/1/edit
  def edit
  end

  # POST /delegation_entries
  # POST /delegation_entries.json
  def create
    @delegation_entry = DelegationEntry.new(delegation_entry_params)

    respond_to do |format|
      if @delegation_entry.save
        format.html { redirect_to @delegation_entry, notice: 'Delegation entry was successfully created.' }
        format.json { render :show, status: :created, location: @delegation_entry }
      else
        format.html { render :new }
        format.json { render json: @delegation_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /delegation_entries/1
  # PATCH/PUT /delegation_entries/1.json
  def update
    respond_to do |format|
      if @delegation_entry.update(delegation_entry_params)
        format.html { redirect_to @delegation_entry, notice: 'Delegation entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @delegation_entry }
      else
        format.html { render :edit }
        format.json { render json: @delegation_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delegation_entries/1
  # DELETE /delegation_entries/1.json
  def destroy
    @delegation_entry.destroy
    respond_to do |format|
      format.html { redirect_to delegation_entries_url, notice: 'Delegation entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delegation_entry
      @delegation_entry = DelegationEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delegation_entry_params
      params.require(:delegation_entry).permit(:delegation_id, :delegate_type, :delegate_id, :position)
    end
end
