class Organization < Voter
  has_and_belongs_to_many :users

  validates :name, presence: true

  acts_as_tagger
  acts_as_voter
end
