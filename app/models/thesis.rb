class Thesis < ActiveRecord::Base
  belongs_to :issue
  belongs_to :author, class_name: 'User'

  def for
    []
  end
end
