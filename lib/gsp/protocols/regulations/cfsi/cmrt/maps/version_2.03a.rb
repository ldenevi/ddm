class GSP::Protocols::Regulations::CFSI::CMRT::Maps::Version2Dot03a
  def self.structure
    yaml =<<-EOT
---
:worksheet_indices:
  :declaration: 3
  :minerals: 3
  :company_level: 3
  :smelter_list: 4
  :smelter_names: 5
  :products: 7
:fields:
  :declaration:
    - :company_name
    - :declaration_scope
    - :description_of_scope
    - :language
    - :company_unique_identifier
    - :address
    - :authorized_company_representative_name
    - :contact_title
    - :contact_email
    - :contact_phone
    - :completion_at
  :minerals:
    # Question 1
    -
      -
        - :question
      -
        - :tantalum
        - :tantalum_comment
      -
        - :tin
        - :tin_comment
      -
        - :gold
        - :gold_comment
      -
        - :tungsten
        - :tungsten_comment
      -
        -
    # Question 2
    -
      -
        - :question
      -
        - :tantalum
        - :tantalum_comment
      -
        - :tin
        - :tin_comment
      -
        - :gold
        - :gold_comment
      -
        - :tungsten
        - :tungsten_comment
      -
        -
    # Question 3
    -
      -
        - :question
      -
        - :tantalum
        - :tantalum_comment
      -
        - :tin
        - :tin_comment
      -
        - :gold
        - :gold_comment
      -
        - :tungsten
        - :tungsten_comment
      -
        -
    # Question 4
    -
      -
        - :question
      -
        - :tantalum
        - :tantalum_comment
      -
        - :tin
        - :tin_comment
      -
        - :gold
        - :gold_comment
      -
        - :tungsten
        - :tungsten_comment
      -
        -
    # Question 5
    -
      -
        - :question
      -
        - :tantalum
        - :tantalum_comment
      -
        - :tin
        - :tin_comment
      -
        - :gold
        - :gold_comment
      -
        - :tungsten
        - :tungsten_comment
      -
        -
    # Question 6
    -
      -
        - :question
      -
        - :tantalum
        - :tantalum_comment
      -
        - :tin
        - :tin_comment
      -
        - :gold
        - :gold_comment
      -
        - :tungsten
        - :tungsten_comment
      -
        -
  :company_level:
    # Question A
    -
      - :question
      - :answer
      - :comment
    # Question B
    -
      - :question
      - :answer
      - :comment
    # Question C
    -
      - :question
      - :answer
      - :comment
    # Question D
    -
      - :question
      - :answer
      - :comment
    # Question E
    -
      - :question
      - :answer
      - :comment
    # Question F
    -
      - :question
      - :answer
      - :comment
    # Question G
    -
      - :question
      - :answer
      - :comment
    # Question H
    -
      - :question
      - :answer
      - :comment
    # Question I
    -
      - :question
      - :answer
      - :comment
    # Question J
    -
      - :question
      - :answer
      - :comment
  :smelter_list:
    - :metal
    - :smelter_reference_list
    - :standard_smelter_name
    - :facility_location_country
    - :smelter_id
    - :facility_location_street_address
    - :facility_location_city
    - :facility_location_province
    - :facility_contact_name
    - :facility_contact_email
    - :proposed_next_steps
    - :mineral_source
    - :mineral_source_location
    - :comment
  :smelter_names:
    - :metal
    - :standard_smelter_name
    - :known_alias
    - :facility_location_country
    - :smelter_id
  :products:
    - :item_number
    - :item_name
    - :comment
EOT
    YAML::load yaml
  end

  def self.cell_definitions
    yaml =<<-EOT
---
:declaration:
  :company_name:
    :row: 7
    :column: 3
  :declaration_scope:
    :row: 8
    :column: 3
  :description_of_scope:
    :row: 9
    :column: 3
  :language:
    :row: 2
    :column: 3
  :company_unique_identifier:
    :row: 11
    :column: 3
  :address:
    :row: 12
    :column: 3
  :authorized_company_representative_name:
    :row: 13
    :column: 3
  :contact_title:
    :row: 14
    :column: 3
  :contact_email:
    :row: 15
    :column: 3
  :contact_phone:
    :row: 16
    :column: 3
  :completion_at:
    :row: 17
    :column: 3
:minerals:
  :start_row: 20
  :question: 1
  :tantalum: 3
  :tantalum_comment: 6
  :tin: 3
  :tin_comment: 6
  :gold: 3
  :gold_comment: 6
  :tungsten: 3
  :tungsten_comment: 6
:company_level:
  :start_row: 58
  :question: 1
  :answer: 3
  :comment: 6
:smelter_list:
  :start_row: 4
  :metal: 1
  :smelter_reference_list: 2
  :standard_smelter_name: 3
  :facility_location_country: 4
  :smelter_id: 5
  :facility_location_street_address: 6
  :facility_location_city: 7
  :facility_location_province: 8
  :facility_contact_name: 9
  :facility_contact_email: 10
  :proposed_next_steps: 11
  :mineral_source: 12
  :mineral_source_location: 13
  :comment: 14
:standard_smelter_name:
  :start_row: 2
  :metal: 0
  :standard_smelter_name: 1
  :known_alias: 2
  :facility_location_country: 3
  :smelter_id: 4
:products:
  :start_row: 5
  :item_number: 1
  :item_name: 2
  :comment: 3
EOT
    YAML::load yaml
  end
end
