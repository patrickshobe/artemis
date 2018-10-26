class Series < ApplicationRecord
  validates_presence_of :episode_count
  validates_presence_of :path
  validates_presence_of :season_count
  validates_presence_of :size_on_disk
  validates_presence_of :title
  validates_presence_of :sonarr_id

  validates_uniqueness_of :sonarr_id


  has_many :episodes
end
