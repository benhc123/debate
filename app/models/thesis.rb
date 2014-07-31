class Thesis < ActiveRecord::Base
  has_paper_trail

  belongs_to :author, class_name: 'User'

  module POSITIONS
    FOR = 'for'
    AGAINST = 'against'
  end

  def for
    []
  end
end
