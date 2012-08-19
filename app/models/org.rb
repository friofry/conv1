class Org < ActiveRecord::Base
  attr_accessible :clade_id, :name, :value
  has_many :dbs
  belongs_to :clade
end
