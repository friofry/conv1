class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.string :name
      t.string :value
      t.integer :track_id

      t.timestamps
    end
  end
end
