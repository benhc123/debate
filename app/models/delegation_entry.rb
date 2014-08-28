class DelegationEntry < ActiveRecord::Base
  belongs_to :delegation
  belongs_to :delegate, class_name: 'Voter'

  acts_as_list scope: :delegation
end
