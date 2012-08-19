class Db < ActiveRecord::Base
  attr_accessible :name, :org_id, :value
  has_many :groups
  belongs_to :org
end
