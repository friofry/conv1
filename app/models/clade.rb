class Clade < ActiveRecord::Base
  attr_accessible :name, :value
  has_many :orgs
  
end
