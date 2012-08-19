# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'tree'
require 'json'

root = JSON.parse(IO.read("db/opts.json"))

# CLADE
root.children.each do |clade_node|
	clade_record = Clade.find_or_create_by_name(:name => clade_node.content, :value => clade_node.name)

	# ORG
	clade_node.children.each do |org_node|
		org_record = Org.find_or_create_by_name(:name => org_node.content, :value => org_node.name, :clade_id => clade_record.id)
		
		# DB
		org_node.children.each do |db_node|
			db_record = Db.find_or_create_by_name(:name => db_node.content, :value => db_node.name, :org_id => org_record.id)

			# GROUP
			db_node.children.each do |group_node|
				group_record = Group.find_or_create_by_name(:name => group_node.content, :value => group_node.name, :db_id => db_record.id)

				# TRACK
				group_node.children.each do |track_node|
					track_record = Track.find_or_create_by_name(:name => track_node.content, :value => track_node.name, :group_id => group_record.id)
					
					# TABLE
					track_node.children.each do |table_node|
						table_record = Table.find_or_create_by_name(:name => table_node.content, :value => table_node.name, :track_id => track_record.id)
					end
				end
			end
		end
	end
end
