puts "Creating regulation/standards agencies..."
agency_sec = Agency.create({:name => 'Securities and Exchange Commission', :acronym => 'SEC', :website => 'sec.gov'})
agency_iso = Agency.create({:name => 'International Organization for Standardization', :acronym => 'ISO', :website => 'iso.org'})
agency_epa = Agency.create({:name => 'Environmental Protection Agency', :acronym => 'EPA', :website => 'epa.gov'})


