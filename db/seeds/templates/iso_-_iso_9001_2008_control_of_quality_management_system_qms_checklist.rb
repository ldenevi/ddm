# encoding: UTF-8
puts "Creating ISO 9001:2008 – Control of Quality Management System (QMS) Checklist ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('ISO'),
                               :full_name => 'ISO 9001:2008 Quality Management System Requirements',
                               :display_name => 'ISO 9001',
                               :description => 'ISO 9001:2008 sets out the criteria for a quality management system.',
                               :regulatory_review_name => 'ISO 9001:2008 – Control of Quality Management System (QMS) Checklist',
                               :frequency => 'Annual'.force_encoding('UTF-8'),                            
                               :objectives => "The organization shall establish, document, implement and maintain a quality management system and continually improve its effectiveness in accordance with the requirements of this International Standard.  Note any exceptions to the organization’s QMS policy and report to the appropriate person for corrective action.  When you identify a means to improve a method, document your findings and forward to the appropriate person.".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "General Requirements",
:instructions => <<EOT
<ol><li>Attach documentation evidencing the following: <br><ol start="1" style="list-style-type: lower-alpha;"><li>The processes required for the QMS have been identified and documented.<br></li><li>The sequence and interaction of processes have been determined.<br></li><li>The criteria and methods the organization uses to ensure that the operation and control of QMS processes are effective.<br></li><li>The organization has provided resources and information needed to support the operation and monitoring of QMS processes.<br></li><li>The organization controls any outsourced process that affects product conformity with requirements.</li></ol></li></ol>

EOT
}

tasks << {
:name => "QMS Documentation Requirements",
:instructions => <<EOT
<ol><li>Does the organization have documented statements of its quality policy and quality objectives?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Attach documentation evidencing the quality policy and objectives. <br></li></ol></li><li>Does the organization have a quality manual?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Attach the Quality Manual<br></li></ol></li><li>Does the Quality Manual contain procedures for the control of:<br><ol start="1" style="list-style-type: lower-alpha;"><li>Documents<br></li><li>Records<br></li><li>Internal Audit<br></li><li>Nonconforming Product<br></li><li>Corrective Action<br></li><li>Preventive Action<br></li></ol></li><li>Does the Quality Manual contain procedures that have been identified as being required to maintain the QMS?</li></ol>

EOT
}

tasks << {
:name => "Control of Documents",
:instructions => <<EOT
<ol><li>Does the document control procedure contained within the QMS define the means of:<br><ol start="1" style="list-style-type: lower-alpha;"><li>Document approval<br></li><li>Document review and re-approval<br></li><li>Identification of revision status<br></li><li>Identification of changes made to documentation<br></li><li>Ensuring that only current and relevant versions of documentation are available at the point of use<br></li><li>Ensuring that documents remain legible<br></li><li>Ensuring that appropriate external documentation is identified<br></li><li>Ensuring that the distribution of external documents is controlled<br></li><li>Removing obsolete documents from use<br></li><li>Ensuring that obsolete documents remain out of use</li></ol></li></ol>

EOT
}

tasks << {
:name => "Control of Records",
:instructions => <<EOT
<ol><li>Does the record control procedure contained within the QMS define the means of:<br><ol start="1" style="list-style-type: lower-alpha;"><li>Identification of Records<br></li><li>Storage of Records<br></li><li>Protection of Records<br></li><li>Retrieval of Records<br></li><li>Disposition of Records</li></ol></li></ol>

EOT
}

tasks << {
:name => "Internal Audit",
:instructions => <<EOT
<ol><li>Does the internal audit procedure contained with the QMS describe:<br><ol start="1" style="list-style-type: lower-alpha;"><li>How internal audits are planned and conducted;<br></li><li>How the audit program takes into account the status and importance of the areas to be audited;<br></li><li>How the audit program takes into account the results of previous audits;<br></li><li>How the audit is defined by criteria, scope, frequency and methods;<br></li><li>How the audits have maintained objectivity and impartiality;<br></li><li>How the organization has been assured that the audit has not been conducted by personnel involved in the audited activity;<br></li><li>How they are documented in conformance with the document management procedure;<br></li><li>How any required corrections and corrective actions are documented and monitored.</li></ol></li></ol>

EOT
}

tasks << {
:name => "Control of Nonconforming Product Procedure",
:instructions => <<EOT
<ol><li>Does the control of nonconforming product procedure contained with the QMS describe:<br><ol start="1" style="list-style-type: lower-alpha;"><li>How does the organization ensure that nonconforming products are identified and controlled to prevent unintended use or delivery;<br></li><li>Who has responsibility and authority to deal with nonconforming products;<br></li><li>What methods does the organization employ to deal with nonconforming products;<br></li><li>How records of nonconforming products, including subsequent actions, are maintained<br></li><li>How nonconforming products that have been corrected are re-verified to ensure conformity;<br></li><li>What actions the organization shall take when it is discovered that nonconforming actions are shipped.</li></ol></li></ol>

EOT
}

tasks << {
:name => "Corrective Action Procedure",
:instructions => <<EOT
<ol><li>Does the Corrective Action procedure contained within the QMS describe:<br><ol start="1" style="list-style-type: lower-alpha;"><li>When a Corrective Action should be initiated to eliminate the cause of a nonconformity to prevent recurrence;<br></li><li>How to evaluate the need for action to ensure that nonconformities do not recur;<br></li><li>The process for identifying nonconformities;<br></li><li>The record keeping process for Corrective Actions taken;<br></li><li>The process for reviewing the effectiveness of the Corrective Action taken.</li></ol></li></ol>

EOT
}

tasks << {
:name => "Preventive Action Procedure",
:instructions => <<EOT
<ol><li>Does the Preventive Action procedure contained within the QMS describe:<br><ol start="1" style="list-style-type: lower-alpha;"><li>How does the organization determine a potential nonconformity that would require a Preventive Action to be initiated to prevent an occurrence;<br></li><li>How to evaluate the need for a Preventive Action to ensure that the nonconformity does not occur;<br></li><li>The process for determining and implementing a Preventive Action that is needed;<br></li><li>The record keeping process for Preventive Actions taken;<br></li><li>The process for reviewing the effectiveness of the Preventive Action taken.</li></ol></li></ol>

EOT
}


template.tasks = tasks.to_json
template.save!
