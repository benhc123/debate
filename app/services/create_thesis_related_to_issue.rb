CreateThesisRelatedToIssue = Struct.new(:thesis_params, :issue, :position) do
  attr_reader :thesis, :success

  def run
    Thesis.transaction do
      @thesis = Thesis.new(thesis_params)
      @success = @thesis.save
      return false unless success?

      @success = issue.send(add_method, @thesis)
      return false unless success?
    end
  end

  def add_method
    position == Thesis::POSITIONS::FOR ? :add_thesis_for : :add_thesis_against
  end

  def success?
    success
  end
end
