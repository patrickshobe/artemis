class CreateEpisode < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.references :series, foreign_key: true
      t.integer :season
      t.integer :unique_id
      t.text :path
      t.bigint :size
      t.string :audio
      t.string :video
      t.boolean :encoded, default: false

      t.timestamps
    end
  end
end
