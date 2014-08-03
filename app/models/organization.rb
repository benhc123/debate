class Organization < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :delegations, as: :voter

  acts_as_tagger
  acts_as_voter
end
