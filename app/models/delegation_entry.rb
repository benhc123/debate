class DelegationEntry < ActiveRecord::Base
  belongs_to :delegation

  acts_as_list scope: :delegation
end
