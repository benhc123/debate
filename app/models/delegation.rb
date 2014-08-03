class Delegation < ActiveRecord::Base
  belongs_to :voter, polymorphic: true
  has_many :tags
  has_and_belongs_to_many :delegation_entries, -> { order("position ASC") }
  acts_as_list scope: :voter
end
