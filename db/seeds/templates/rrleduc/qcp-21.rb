puts "Creating R. R. LeDuc Template QCP-21 ..."
template = GspTemplate.create({:agency => Agency.find_by_name('In-House'),
                               :full_name => 'LeDuc Corporation',
                               :display_name => 'Internal Quality Audit',
                               :description => 'The purpose for this procedure is to assure that operations, processes, work instructions, and procedures are periodically examined/audited for accuracy.',
                               :regulatory_review_name => 'QCP - 21',
                               :frequency => 'Quarterly',                            
                               :objectives => "It shall be the responsibility of the Quality Control Manager, or Alternate, to conduct quality audits from a documented procedure. It will be at the discretion of the QCM to have a team member accompany him when an audit is to be performed. The QCM, or Alternate, shall also be classified as the Lead Auditor. The Lead Auditor shall be responsible to generate an in-house DMR, Form QC1003, when Cause & Corrective is warranted. Also, and at his discretion, the Auditor may elect to have a Gig / Finding spot corrected, in lieu of a formal write-up."
                               })
                      
tasks = []

tasks << {
:name => "NC PUNCH - Internal Quality Audit",
:instructions => <<EOT
1. Is the Traveler and Drawing on hand?
2. Does the Rev Level on Traveler match the Rev Level on Drawing?
3. Ask the operator, "How do you verify that the correct tool is loaded?" Document the response.
4. Ask the operator, "Did you perform daily maintenance required on your machine?" Document the response.
EOT
}

tasks << {
:name => "FORM - Internal Quality Audit",
:instructions => <<EOT
1. Is the Traveler and Drawing on hand?
2. Ask the operator, "Did you perform 1st piece inspection prior to production run?"
3. Ask the operator, "How do you know that you are working to the correct Rev?"
4. Ask the operator, "When the job package is in red jacket, do you call on QC?"
EOT
}

tasks << {
:name => "PEM - Internal Quality Audit",
:instructions => <<EOT
1. Ask the operator, Is the Traveler and Drawing on hand?
2. Ask the operator, "How do you verify that you are installing the correct pemnut?"
3. Ask the operator, "How do you determine the pemnut is fully inserted?"
4. Ask the operator, "How do you verify an sst pem vs. zinc plated pem?"
EOT
}

tasks << {
:name => "WELD - Internal Quality Audit",
:instructions => <<EOT
1. Is the Traveler and Drawing on hand?
2. Ask the operator, "How did you know what size the weld is, what surface, how large?"
3. Ask the operator, "How do you test the integrity of your weld?"
4. Ask the operator, "When given a sample piece, how do you determine that it's current?"
EOT
}

tasks << {
:name => "FINISHING - Internal Quality Audit",
:instructions => <<EOT
1. Ask the operator, "Is the Traveler and Drawing on hand?"
2. Ask the operator, "What determines the grinding tool to use on edges and corners?"
3. Ask the operator, "When you see that a weld is incomplete, what action to you take?"
EOT
}

tasks << {
:name => "PAINT - Internal Quality Audit",
:instructions => <<EOT
1. Is the Traveler and Drawing on hand?
2. Ask the operator, "Do you perform daily chemical testing?"
3. Ask the operator, "How do you determine that the color and texture is correct?"
4. Ask the operator, "Do you perform testing for paint adherence?  Are records kept?"
EOT
}

tasks << {
:name => "ASSEMBLY - Internal Quality Audit",
:instructions => <<EOT
1. Is the Traveler and Drawing on hand?
2. Ask the operator, "What action do you take when you see heavy scratches on parts?"
3. Ask the operator, "Do you final inspect your assembly prior to move to shipping?"
EOT
}

template.tasks = tasks.to_json
template.save!

