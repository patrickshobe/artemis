class Series < ApplicationRecord
  validates_presence_of :episode_count
  validates_presence_of :path
  validates_presence_of :season_count
  validates_presence_of :size_on_disk
  validates_presence_of :title

  has_many :episodes
end
