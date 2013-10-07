puts "Creating regulation/standards agencies..."
agency_self = Agency.create({:name => 'In-House', :acronym => "In_House", :website => nil})
agency_sec  = Agency.create({:name => 'Securities and Exchange Commission', :acronym => 'SEC', :website => 'sec.gov'})
agency_iso  = Agency.create({:name => 'International Organization for Standardization', :acronym => 'ISO', :website => 'iso.org'})
agency_epa  = Agency.create({:name => 'Environmental Protection Agency', :acronym => 'EPA', :website => 'epa.gov'})
agency_gsp  = Agency.create({:name => 'Green Status Pro', :acronym => 'GSP', :website => 'greenstatuspro.com'})
agency_eicc = Agency.create({:name => 'Electronic Industry Citizenship Coalition', :acronym => 'EICC', :website => 'www.eicc.info'})
