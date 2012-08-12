class EncodeRequestController < ApplicationController
	include EncodeRequestHelper
	def prepare
		@request_params ||= {
			"clade" => "mammal",
			"org" => "Human",
			"db" => "hg19",
			"hgta_group" => "rna",
			"hgta_track" => "mrna",
			"hgta_table" => "refGene"
		}
		@@agent ||= Mechanize.new
	end

	def extract
		session[:sequences] = GetSequences(params, @@agent)
	end
end
