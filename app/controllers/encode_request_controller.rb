class EncodeRequestController < ApplicationController
  def prepare
	@request_params ||= {
		"clade" => "Mammal",
		"org" => "Human",
		"db" => "Feb. 2009 (CRCh37/hg19)",
		"hgta_group" => "mRNA and EST Tracks",
		"hgta_track" => "Human mRNAs",
		"hgta_table" => "RefSeq Genes (refGene)"
	}
  end
  
  def extract
  end
end
