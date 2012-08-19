class CreateDbs < ActiveRecord::Migration
  def change
    create_table :dbs do |t|
      t.string :name
      t.string :value
      t.integer :org_id

      t.timestamps
    end
  end
end
