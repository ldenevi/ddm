puts "Creating regulation/standards agencies..."
agency_self = Agency.create({:name => 'In-House -- In_House', :website => nil})
agency_sec  = Agency.create({:name => 'Securities and Exchange Commission -- SEC', :website => 'sec.gov'})
agency_iso  = Agency.create({:name => 'International Organization for Standardization -- ISO', :website => 'iso.org'})
agency_epa  = Agency.create({:name => 'Environmental Protection Agency -- EPA', :website => 'epa.gov'})
agency_gsp  = Agency.create({:name => 'Green Status Pro -- GSP', :website => 'greenstatuspro.com'})
agency_eicc = Agency.create({:name => 'Electronic Industry Citizenship Coalition -- EICC', :website => 'www.eicc.info'})
