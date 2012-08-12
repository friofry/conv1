module EncodeRequestHelper
	def GetSequences(params)
		encode_url = "http://genome.ucsc.edu/cgi-bin/hgTables?"
		encode_url += "clade=#{params["clade"]}&org=#{params["org"]}&"
		encode_url += "db=#{params["db"]}&hgta_group=#{params["hgta_group"]}&hgta_track=#{params["hgta_track"]}&"
		encode_url += "hgta_table=#{params["hgta_table"]}"
		encode_url += "&hgta_regionType=genome&hgta_outputType=sequence"

		agent = Mechanize.new
		
		logger.info "1 - encode Table Browser page\n"
		main_page = agent.get(encode_url)

		submit_id_form =  main_page.form_with(:name => 'mainForm')	
		paste_button = submit_id_form.button_with(:name => 'hgta_doPasteIdentifiers')

		logger.info "2 - click paste button \n"
		input_ids_page = submit_id_form.click_button(paste_button)

		#gene_ids = params["gene_ids"].split(",")
		genes_text = params["gene_ids"]#gene_ids.join("\n")
		logger.info  "3 - input gene ids: #{genes_text}\n"		
		input_genes_form = input_ids_page.form_with(:action => '/cgi-bin/hgTables')
		input_genes_form['hgta_pastedIdentifiers'] = genes_text
		submit_paste_button = input_genes_form.button_with(:name => 'hgta_doPastedIdentiers')
		main_page_2 = input_genes_form.click_button(submit_paste_button)

		logger.info "4 - click 'get output' button\n"
		main_form_2 = main_page_2.form_with(:name => "mainForm")
		go_button = main_form_2.button_with(:name => "hgta_doTopSubmit")
		select_page = main_form_2.click_button(go_button)

		logger.info "5 - click 'genomic' radio button\n"
		select_form = select_page.form_with(:action => '/cgi-bin/hgTables')
		#select_form.radiobutton_with(:name => 'hgta_geneSeqType').check
		select_form.radiobutton_with(:value => 'genomic').check
			
		logger.info "6 - click sumbit\n"
		submit_button = select_form.button_with(:name => 'hgta_doGenePredSequence')
		options_page = select_form.click_button(submit_button)

		logger.info "7 - check upstream, downstream, uncheck 5', 3', CDS...\n"
		options_form = options_page.form_with(:action => '/cgi-bin/hgTables')
		options_form.checkbox_with(:name => 'hgSeq.promoter').check
		options_form['hgSeq.promoterSize'] = params["upstream"] || 500

		options_form.checkbox_with(:name => 'hgSeq.utrExon5').uncheck
		options_form.checkbox_with(:name => 'hgSeq.cdsExon').uncheck
		options_form.checkbox_with(:name => 'hgSeq.utrExon3').uncheck

		options_form.checkbox_with(:name => 'hgSeq.intron').uncheck

		options_form.checkbox_with(:name => 'hgSeq.downstream').check
		options_form['hgSeq.downstreamSize'] = params["downstream"] || 500
		get_button = options_form.button_with(:name => 'hgta_doGenomicDna')

		logger.info "8 - get data \n"
		data_page = options_form.click_button(get_button)
		File.delete(output_file) if File.exist?(output_file)
		#data_page.save_as(output_file)	
		return data_page.content
	end
end
