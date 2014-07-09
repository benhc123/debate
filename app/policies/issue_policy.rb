class IssuePolicy
  attr_reader :user, :issue

  def initialize(user, issue)
    @user = user
    @issue = issue
  end

  def new?
    @user
  end

  def update?
     author_or_admin
  end

  def destroy?
    author_or_admin
  end

  def author_or_admin
    @user and ( @issue.author == @user or @user.admin? )
  end

  def vote?
    @user
  end

  [:voteyea?, :votenay?, :upvote?, :downvote?].each{ |method| alias_method method, :vote? }
end
