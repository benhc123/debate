class ThesisPolicy
  attr_reader :user, :issue

  def initialize(user, thesis)
    @user = user
    @thesis = thesis
  end

  def new?
    @user
  end

  def update?
     @user
  end

  def destroy?
    author_or_admin
  end

  def author_or_admin
    @user and ( @thesis.author == @user or @user.admin? )
  end
end
