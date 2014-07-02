class Issue < ActiveRecord::Base
  enum position: [:for, :against, :neutral, :abstain]
  
  belongs_to :author, class_name: 'User'
  has_many :theses

  validates :author, presence: true

  acts_as_votable
end
