class CreateEpisode < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.references :series, foreign_key: true
      t.integer    :episode_file_id
      t.integer    :season_number
      t.integer    :episode_number
      t.text       :title
      t.date       :air_date
      t.boolean    :has_file
      t.integer    :absolute_episode_number
      t.integer    :sonarr_id
      t.text       :path
      t.bigint     :size
      t.date       :date_added
      t.string     :audio
      t.string     :video
      t.boolean    :encoded, default: false

      t.timestamps
    end
  end
end
