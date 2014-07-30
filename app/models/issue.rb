class Issue < ActiveRecord::Base
  versioned class_name: 'IssueVersion'

  enum position: [:for, :against, :neutral, :abstain]

  belongs_to :author, class_name: 'User'
  has_many :theses

  validates :author, presence: true
  validates :title, presence: true

  acts_as_votable
  acts_as_ordered_taggable
end
