class CreateClades < ActiveRecord::Migration
  def change
    create_table :clades do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
