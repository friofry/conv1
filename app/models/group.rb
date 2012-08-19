class Group < ActiveRecord::Base
  attr_accessible :db_id, :name, :value
  has_many :tracks
  belongs_to :db
end
