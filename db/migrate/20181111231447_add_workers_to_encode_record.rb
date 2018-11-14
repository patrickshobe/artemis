class AddWorkersToEncodeRecord < ActiveRecord::Migration[5.2]
  def change
    add_reference :encode_records, :workers, index: true
    add_column :encode_records, :started_at, :datetime
  end
end
