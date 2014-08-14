module GSP::Protocols::Regulations::CFSI::CMRT
  autoload :Exceptions, File.join('gsp', 'protocols', 'regulations', 'cfsi', 'cmrt', 'exceptions')
  autoload :Maps, File.join('gsp', 'protocols', 'regulations', 'cfsi', 'cmrt', 'maps')
  autoload :V2ToV3IdTranslation, File.join('gsp', 'protocols', 'regulations', 'cfsi', 'cmrt', 'v2_to_v3_id_translation')
  autoload :ValidateV2SmelterIdCountryCode, File.join('gsp', 'protocols', 'regulations', 'cfsi', 'cmrt', 'validate_v2_smelter_id_country_code')
  autoload :Versions, File.join('gsp', 'protocols', 'regulations', 'cfsi', 'cmrt', 'versions')
end
