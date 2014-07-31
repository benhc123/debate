class Thesis < ActiveRecord::Base
  has_paper_trail

  belongs_to :issue
  belongs_to :author, class_name: 'User'

  def for
    []
  end
end
