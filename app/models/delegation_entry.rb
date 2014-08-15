class DelegationEntry < ActiveRecord::Base
  belongs_to :delegation
  belongs_to :delegate, polymorphic: true

  acts_as_list scope: :delegation
end
