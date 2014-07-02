class IssuePolicy
  attr_reader :user, :issue

  def initialize(user, issue)
    @user = user
    @issue = issue
  end

  def new?
    @user
  end

  def destroy?
    @issue.author == @user or @user.admin?
  end

end
