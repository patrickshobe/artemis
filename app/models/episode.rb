class Episode < ApplicationRecord
  validates_presence_of :episode_file_id
  validates_presence_of :season_number
  validates_presence_of :episode_number
  validates_presence_of :title
  validates_presence_of :air_date
  validates_presence_of :has_file
  validates_presence_of :sonarr_id
  validates_presence_of :path
  validates_presence_of :size
  validates_presence_of :date_added
  validates_presence_of :audio
  validates_presence_of :video
  validates_uniqueness_of :sonarr_id

  belongs_to :series
  has_many :encode_jobs
end
