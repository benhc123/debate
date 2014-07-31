UpdateThesis = Struct.new(:thesis, :params, :issue) do
  attr_reader :success

  def run
    @success = thesis.transaction do
      thesis.update_attributes(params) and issue.touch_with_version
    end
  end

  def success?
    success
  end
end
