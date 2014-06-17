class Cfsi::DeclarationValidator < ActiveModel::Validator
  def validate(declaration)
    case declaration.version.split('.').first
      when '2' then extend GSP::Protocols::Regulations::CFSI::CMRT::Validation::Version2
      when '3' then extend GSP::Protocols::Regulations::CFSI::CMRT::Validation::Version3
    end
    run_validations(declaration)
  end
end
