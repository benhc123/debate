class Issue < ActiveRecord::Base
  belongs_to :author, class_name: 'User'

  acts_as_voteable
end
