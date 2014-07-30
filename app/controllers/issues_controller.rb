class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :voteyea, :votenay, :revert]

  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.all
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
  end

  # GET /issues/new
  def new
    @issue = Issue.new
    authorize @issue
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(issue_params)
    @issue.author = current_user

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url, notice: 'Issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    do_vote true, :visibility
  end

  def downvote
    do_vote false, :visibility
  end

  def vote vote, scope
    authorize @issue

    @issue.vote_by voter: current_user, vote: vote, vote_scope: scope
    if not @issue.vote_registered?
      @issue.unvote_by current_user, vote_scope: scope
    end
  end

  def voteyea
    do_vote true, :approval
  end

  def votenay
    do_vote false, :approval
  end

  def revert
    version_number = params[:issue][:version].to_i
    already_at_desired_version = version_number == @issue.versions.last.index
    no_version_to_switch_to = @issue.versions.count < 2
    return redirect_to @issue if already_at_desired_version or no_version_to_switch_to

    reified = @issue.versions[version_number].next.reify
    reified.save
    redirect_to @issue
  end

  private

  def set_issue
    @issue = Issue.find(params[:id])
  end

  def issue_params
    params.require(:issue).permit(:title, :text, :author_id)
  end

  def do_vote *args
    vote *args
    redirect_to :back
  end
end
