class Delegation < ActiveRecord::Base
  belongs_to :voter, class_name: 'User'
end