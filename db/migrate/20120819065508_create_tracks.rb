class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :value
      t.integer :group_id

      t.timestamps
    end
  end
end
