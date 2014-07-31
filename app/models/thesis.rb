class Thesis < ActiveRecord::Base
  has_paper_trail

  belongs_to :author, class_name: 'User'

  module POSITIONS
    FOR = 'for'
    AGAINST = 'against'
  end

  def revert_to!(version_number, issue)
    version = self.versions[version_number]
    reified = version.next.reify

    reified.transaction do
      reified.save
      issue.touch_with_version
    end
  end
end
