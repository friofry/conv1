class CreateOrgs < ActiveRecord::Migration
  def change
    create_table :orgs do |t|
      t.string :name
      t.string :value
      t.integer :clade_id

      t.timestamps
    end
  end
end
