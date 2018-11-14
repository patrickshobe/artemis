class CreateWorkers < ActiveRecord::Migration[5.2]
  def change
    create_table :workers do |t|
      t.string :name
      t.string :location
      t.string :access_token

      t.timestamps
    end
  end
end
