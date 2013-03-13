require 'fileutils'

namespace :gsp do
  desc "Dump all saved templates into GSP import format"
  task :dump_templates => :environment do
   
import_script_template_attributes =<<EOT
puts "Creating %s ..."
template = GspTemplate.create({:agency => Agency.find_by_acronym('%s'),
                               :full_name => '%s',
                               :display_name => '%s',
                               :description => '%s',
                               :regulatory_review_name => '%s',
                               :frequency => '%s',                            
                               :objectives => "%s"
                               })

tasks = []

EOT

import_script_template_task =<<EOTsk
tasks << {
:name => "%s",
:instructions => <<EOT
%s
EOT
}

EOTsk

import_script_templates_save_task =<<EOT

template.tasks = tasks.to_json
template.save!
EOT
   
   GspTemplate.all.each do |template|
    dump_dir = File.join('.', 'db', 'seeds', 'templates', 'db_dump')
    FileUtils.mkdir_p(dump_dir)
    
    filename = [template.agency.acronym, template.regulatory_review_name].join('_-_').gsub(/[^\w|-]/, '_').gsub(/_+/, '_').downcase
    
    output = import_script_template_attributes % [template.regulatory_review_name, template.agency.acronym, template.full_name,
                                                  template.display_name, template.description, template.regulatory_review_name,
                                                  template.frequency, template.objectives]
    
    JSON.parse(template.tasks).each do |task|
      output << import_script_template_task % [task["name"], task["instructions"]]
    end
    
    output << import_script_templates_save_task
    
    output_filepath = File.join(dump_dir, filename + '.rb')
    
    File.open(output_filepath, 'w') { |f| f.write(output) }
    puts "Dumped #{output_filepath}"
   end
   
    
  end

end
