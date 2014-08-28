class Voter < ActiveRecord::Base
  has_many :delegations
  has_many :delegation_entries, as: :delegate

  def display
    name || 'Anon'
  end
end
