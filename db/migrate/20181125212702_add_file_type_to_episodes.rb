class AddFileTypeToEpisodes < ActiveRecord::Migration[5.2]
  def change
    add_column :episodes, :file_type, :string
  end
end
