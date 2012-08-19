class Table < ActiveRecord::Base
  attr_accessible :name, :track_id, :value
  belongs_to :tracks
end
