class CreateEncodeRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :encode_records do |t|
      t.references :episode, foreign_key: true
      t.boolean :success, default: false
      t.datetime :finished_at
      t.bigint :initial_size
      t.bigint :final_size

      t.timestamps
    end
  end
end
