class CreateSeries < ActiveRecord::Migration[5.2]
  def change
    create_table :series do |t|
      t.string :title
      t.integer :season_count
      t.integer :episode_count
      t.bigint :size_on_disk
      t.string :path

      t.timestamps
    end
  end
end
