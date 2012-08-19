Conv1::Application.routes.draw do
	post "encode_request/extract"
	get 'encode_request/update_orgs', :as => 'update_orgs'
	get 'encode_request/update_dbs', :as => 'update_dbs'
	get 'encode_request/update_groups', :as => 'update_groups'
	get 'encode_request/update_tracks', :as => 'update_tracks'
	get 'encode_request/update_tables', :as => 'update_tables'
	root :to => "encode_request#prepare"
end
