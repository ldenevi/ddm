puts "Creating regulation/standards agencies..."
agency_self = Agency.create({:name => 'In-House', :website => nil, :acronym => 'In-House'})
agency_sec  = Agency.create({:name => 'Securities and Exchange Commission', :website => 'sec.gov', :acronym => 'SEC'})
agency_iso  = Agency.create({:name => 'International Organization for Standardization', :website => 'iso.org', :acronym => 'ISO'})
agency_epa  = Agency.create({:name => 'Environmental Protection Agency', :website => 'epa.gov', :acronym => 'EPA'})
agency_gsp  = Agency.create({:name => 'Green Status Pro', :website => 'greenstatuspro.com', :acronym => 'GSP'})
agency_cfsi = Agency.create({:name => 'Conflict-Free Sourcing Initiative', :website => 'www.conflictfreesourcing.org', :acronym => 'CFSI'})
