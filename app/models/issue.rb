class Issue < ActiveRecord::Base
  belongs_to :author, class_name: 'User'

  validates :author, presence: true

  acts_as_votable
end
