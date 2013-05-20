require 'fileutils'

namespace :gsp do

  namespace :app do
    desc "Deploy reviews"
    task :deploy_reviews => :environment do
      # TODO: Make the deploy date and start date configurable, rather than fixed
      deploy_date = Time.now + 1.week
      organization_templates = OrganizationTemplate.all.select { |ot| ot.occurs_on?(deploy_date) }
      puts "%d organization templates to deploy" % organization_templates.size
      organization_templates.each { |ot| ot.deploy_review }
    end
  end

  namespace :db do
    desc "Dump all saved templates into GSP import format"
    task :dump_templates => :environment do
   
import_script_template_attributes =<<EOT
# encoding: UTF-8
puts "Creating %s ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('%s'),
                               :full_name => '%s',
                               :display_name => '%s',
                               :description => '%s',
                               :regulatory_review_name => '%s',
                               :frequency => '%s'.force_encoding('UTF-8'),
                               :objectives => "%s".force_encoding('UTF-8')
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
                                                  template.frequency, template.objectives.gsub('"', '\"')]
    
    JSON.parse(template.tasks).each do |task|
      output << import_script_template_task % [task["name"], task["instructions"]]
    end
    
    output << import_script_templates_save_task
    
    output_filepath = File.join(dump_dir, filename + '.rb')
    
    File.open(output_filepath, 'w') { |f| f.write(output) }
    puts "Dumped #{output_filepath}"
   end
   
    
  end
  
  
  desc "WARNING! Drops, rebuilds, seeds entire database"
  task :total_reset => :environment do
    # rake db:migrate VERSION=0 ;rake db:migrate; rake db:seed
    system('rake db:drop; rake db:create; rake db:migrate; rake db:seed')
  end
  
  
  
  end
    
end
