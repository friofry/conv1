class EncodeRequestController < ApplicationController
	include EncodeRequestHelper
	def prepare
		@current_params ||= {
			:clade => "mammal",
			:org => "Human",
			:db => "hg19",
			:group => "rna",
			:track => "mrna",
			:table => "refGene"
		}

		@clades = Clade.all
		@orgs = Clade.find_by_value(@current_params[:clade]).orgs
		@dbs = Org.find_by_value(@current_params[:org]).dbs
		@groups = Db.find_by_value(@current_params[:db]).groups
		@tracks = Group.find_by_value(@current_params[:group]).tracks
		@tables = Track.find_by_value( @current_params[:track]).tables
	end
	def update_orgs
		@orgs= Clade.find_by_value(params[:clade]).orgs
	end
	def update_dbs
		@dbs= Org.find_by_value(params[:org]).dbs
		logger.debug @dbs.inspect
	end
	def update_groups
		@groups = Db.find_by_value(params[:db]).groups
	end
	def update_tracks
		@tracks = Group.find_by_value(params[:group]).tracks
	end
	def update_tables
		@tables = Track.find_by_value(params[:track]).tables
	end

	def extract
		session[:sequences] = GetSequences(params)
	end
end
