# encoding: UTF-8
puts "Creating QCP - 21 ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('In_House'),
                               :full_name => 'R.R. LeDuc Corporation',
                               :display_name => 'Internal Quality Audit',
                               :description => 'The purpose for this procedure is to assure that operations, processes, work instructions, and procedures are periodically examined/audited for accuracy.',
                               :regulatory_review_name => 'QCP - 21',
                               :frequency => 'Quarterly'.force_encoding('UTF-8'),
                               :objectives => "<p>It shall be the responsibility of the Quality Control Manager, or Alternate, to conduct quality audits from a documented procedure. It will be at the discretion of the QCM to have a team member accompany him when an audit is to be performed. The QCM, or Alternate, shall also be classified as the Lead Auditor. The Lead Auditor shall be responsible to generate an in-house DMR, Form QC1003, when Cause &amp; Corrective is warranted. Also, and at his discretion, the Auditor may elect to have a Gig / Finding spot corrected, in lieu of a formal write-up.</p>".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "NC PUNCH - Internal Quality Audit",
:instructions => <<EOT
<ol><li>Is the Traveler and Drawing on hand?</li><li>Does the Rev Level on Traveler match the Rev Level on Drawing?</li><li>Ask the operator, "How do you verify that the correct tool is loaded?" Document the response.</li><li>Ask the operator, "Did you perform daily maintenance required on your machine?" Document the response.</li></ol>



EOT
}

tasks << {
:name => "FORM - Internal Quality Audit",
:instructions => <<EOT
<ol>
<li>Is the Traveler and Drawing on hand?</li>
<li>Ask the operator, "Did you perform 1st piece inspection prior to production run?"</li>
<li>Ask the operator, "How do you know that you are working to the correct Rev?"</li>
<li>Ask the operator, "When the job package is in red jacket, do you call on QC?"</li>
</ol>


EOT
}

tasks << {
:name => "PEM - Internal Quality Audit",
:instructions => <<EOT
<ol>
<li>Ask the operator, Is the Traveler and Drawing on hand?</li>
<li>Ask the operator, "How do you verify that you are installing the correct pemnut?"</li>
<li>Ask the operator, "How do you determine the pemnut is fully inserted?"</li>
<li>Ask the operator, "How do you verify an sst pem vs. zinc plated pem?"</li>
</ol>


EOT
}

tasks << {
:name => "WELD - Internal Quality Audit",
:instructions => <<EOT
<ol>
<li>Is the Traveler and Drawing on hand?</li>
<li>Ask the operator, "How did you know what size the weld is, what surface, how large?"</li>
<li>Ask the operator, "How do you test the integrity of your weld?"</li>
<li>Ask the operator, "When given a sample piece, how do you determine that it's current?"</li>
</ol>




EOT
}

tasks << {
:name => "FINISHING - Internal Quality Audit",
:instructions => <<EOT
<ol>
<li>Ask the operator, "Is the Traveler and Drawing on hand?"</li>
<li>Ask the operator, "What determines the grinding tool to use on edges and corners?"</li>
<li>Ask the operator, "When you see that a weld is incomplete, what action to you take?"</li>
</ol>


EOT
}

tasks << {
:name => "PAINT - Internal Quality Audit",
:instructions => <<EOT
<ol>
<li>Is the Traveler and Drawing on hand?</li>
<li>Ask the operator, "Do you perform daily chemical testing?"</li>
<li>Ask the operator, "How do you determine that the color and texture is correct?"</li>
<li>Ask the operator, "Do you perform testing for paint adherence?  Are records kept?"</li>
</ol>


EOT
}

tasks << {
:name => "ASSEMBLY - Internal Quality Audit",
:instructions => <<EOT
<ol>
<li>Is the Traveler and Drawing on hand?</li>
<li>Ask the operator, "What action do you take when you see heavy scratches on parts?"</li>
<li>Ask the operator, "Do you final inspect your assembly prior to move to shipping?"</li>
</ol>


EOT
}


template.tasks = tasks.to_json
template.save!
