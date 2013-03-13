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
1.	Attach documentation evidencing the following:
a.	The processes required for the QMS have been identified and documented.
b.	The sequence and interaction of processes have been determined.
c.	The criteria and methods the organization uses to ensure that the operation and control of QMS processes are effective.
d.	The organization has provided resources and information needed to support the operation and monitoring of QMS processes.
e.	The organization controls any outsourced process that affects product conformity with requirements.

EOT
}

tasks << {
:name => "QMS Documentation Requirements",
:instructions => <<EOT
1.	Does the organization have documented statements of its quality policy and quality objectives?
a.	Attach documentation evidencing the quality policy and objectives.
2.	Does the organization have a quality manual?
a.	Attach the Quality Manual
3.	Does the Quality Manual contain procedures for the control of:
a.	Documents
b.	Records
c.	Internal Audit
d.	Nonconforming Product
e.	Corrective Action
f.	Preventive Action
4.	Does the Quality Manual contain procedures that have been identified as being required to maintain the QMS?

EOT
}

tasks << {
:name => "Control of Documents",
:instructions => <<EOT
1.	Does the document control procedure contained within the QMS define the means of:
a.	Document approval
b.	Document review and re-approval
c.	Identification of revision status
d.	Identification of changes made to documentation
e.	Ensuring that only current and relevant versions of documentation are available at the point of use
f.	Ensuring that documents remain legible
g.	Ensuring that appropriate external documentation is identified
h.	Ensuring that the distribution of external documents is controlled
i.	Removing obsolete documents from use
j.	Ensuring that obsolete documents remain out of use

EOT
}

tasks << {
:name => "Control of Records",
:instructions => <<EOT
1.	Does the record control procedure contained within the QMS define the means of:
a.	Identification of Records
b.	Storage of Records
c.	Protection of Records
d.	Retrieval of Records
e.	Disposition of Records

EOT
}

tasks << {
:name => "Internal Audit",
:instructions => <<EOT
1.	Does the internal audit procedure contained with the QMS describe:
a.	How internal audits are planned and conducted;
b.	How the audit program takes into account the status and importance of the areas to be audited;
c.	How the audit program takes into account the results of previous audits;
d.	How the audit is defined by criteria, scope, frequency and methods;
e.	How the audits have maintained objectivity and impartiality;
f.	How the organization has been assured that the audit has not been conducted by personnel involved in the audited activity;
g.	How they are documented in conformance with the document management procedure;
h.	How any required corrections and corrective actions are documented and monitored.

EOT
}

tasks << {
:name => "Control of Nonconforming Product Procedure",
:instructions => <<EOT
1.	Does the control of nonconforming product procedure contained with the QMS describe:
a.	How does the organization ensure that nonconforming products are identified and controlled to prevent unintended use or delivery;
b.	Who has responsibility and authority to deal with nonconforming products;
c.	What methods does the organization employ to deal with nonconforming products;
d.	How records of nonconforming products, including subsequent actions, are maintained
e.	How nonconforming products that have been corrected are re-verified to ensure conformity;
f.	What actions the organization shall take when it is discovered that nonconforming actions are shipped.

EOT
}

tasks << {
:name => "Corrective Action Procedure",
:instructions => <<EOT
1.	Does the Corrective Action procedure contained within the QMS describe:
a.	When a Corrective Action should be initiated to eliminate the cause of a nonconformity to prevent recurrence;
b.	How to evaluate the need for action to ensure that nonconformities do not recur;
c.	The process for identifying nonconformities;
d.	The record keeping process for Corrective Actions taken;
e.	The process for reviewing the effectiveness of the Corrective Action taken.

EOT
}

tasks << {
:name => "Preventive Action Procedure",
:instructions => <<EOT
1.	Does the Preventive Action procedure contained within the QMS describe:
a.	How does the organization determine a potential nonconformity that would require a Preventive Action to be initiated to prevent an occurrence;
b.	How to evaluate the need for a Preventive Action to ensure that the nonconformity does not occur;
c.	The process for determining and implementing a Preventive Action that is needed;
d.	The record keeping process for Preventive Actions taken;
e.	The process for reviewing the effectiveness of the Preventive Action taken.

EOT
}


template.tasks = tasks.to_json
template.save!
