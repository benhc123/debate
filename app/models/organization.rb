class Organization < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :delegations, as: :voter
  has_many :delegation_entries, as: :delegate

  acts_as_tagger
  acts_as_voter
end
