class Episode < ApplicationRecord
  validates_presence_of :season
  validates_presence_of :path
  validates_presence_of :size
  validates_presence_of :audio
  validates_presence_of :video
  validates_presence_of :unique_id
  validates_uniqueness_of :unique_id

  belongs_to :series
end
