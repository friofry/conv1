class Track < ActiveRecord::Base
  attr_accessible :group_id, :name, :value
  has_many :tables
  belongs_to :group
end
