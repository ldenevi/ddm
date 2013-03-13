# encoding: UTF-8
puts "Creating ISO 9001:2008 – Management Responsibilities Checklist  ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('ISO'),
                               :full_name => 'ISO 9001:2008 Quality Management System Requirements',
                               :display_name => 'ISO 9001',
                               :description => 'ISO 9001:2008 sets out the criteria for a quality management system.',
                               :regulatory_review_name => 'ISO 9001:2008 – Management Responsibilities Checklist ',
                               :frequency => 'Annual'.force_encoding('UTF-8'),                            
                               :objectives => "Top management must provide evidence of its commitment to develop and implement the quality management system and continually improve its effectiveness.  Read through all the task instructions to understand how to meet this objective.  Then interview senior management at your organization to verify their commitment to the quality management system.  Note any exceptions to the organization’s QMS policy and report to the appropriate person for corrective action.  When you identify methods to improve a process, document your findings and forward to the appropriate person.".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "Management Commitment",
:instructions => <<EOT
1.	Select three senior executives to interview regarding the firm’s commitment to the quality management system.  
a.	List their name, initials, title, date interviewed and state why each is qualified to represent the organization’s commitment to quality management.  In subsequent Tasks, use their initials to identify their statements.
2.	Document each executive’s verbal answer to the question: “What is the quality management policy statement for your organization?”  
a.	Attach the written Quality Management Policy Statement.  
b.	Attach documents evidencing that the written quality policy statement was approved by senior management.
3.	Document each executive’s answer to the question: “What aspect of your organization’s quality management policy statement specifies a commitment to continual improvement?  How has that commitment been demonstrated?” 
a.	Attach documents evidencing management’s commitment to continual improvement.

EOT
}

tasks << {
:name => "Management’s Quality Objectives",
:instructions => <<EOT
1.	Document each executive’s answer to the question: “How does your organization’s quality policy provide a framework for supporting its quality objectives?”
a.	List the quality objectives (which need not be stated in the quality policy) and relate each to how the organization’s quality policy supports it.

EOT
}

tasks << {
:name => "Management’s Continuing Suitability Review ",
:instructions => <<EOT
1.	Document each executive’s answer to the question: “How is the quality policy reviewed for continued suitability with respect to major changes in the organization or customer base?”
a.	Attach documents evidencing reviews of the quality policy regarding its suitability to support organizational changes during the previous year.

EOT
}

tasks << {
:name => "Management Communications ",
:instructions => <<EOT
1.	Document each executive’s answer to the question: “How have you communicated your organization’s quality policy throughout the organization?”
a.	Attach documents evidencing the communications of the organization’s quality policy to its employees. 
2.	Document each executive’s answer to the question: “How is the importance of conforming to customer requirements communicated throughout the organization?”
a.	Attach documents evidencing both management’s understanding of customer requirements and communication of these requirements to its employees.

EOT
}

tasks << {
:name => "Management’s Quality Objectives",
:instructions => <<EOT
1.	Document each executive’s answer to the question: “What measurable goals or objectives have been established to support the quality policy and verify the effective performance of the quality management system?  How are these quality objectives tracked and monitored?”
a.	Attach documents evidencing the establishment of quality goals and management’s monitoring of performance meeting these quality objectives.
2.	Document each executive’s answer to the question: “How are theses quality objectives set at the different functional levels throughout the organization?  How are these quality objectives tracked and monitored?”
a.	Attach documents evidencing the establishment of quality goals and management’s monitoring of performance towards meeting those quality objectives at different functional levels throughout the organization.
3.	Document each executive’s answer to the question: “Are quality objectives being achieved?”
a.	Attach documents evidencing whether or not quality objectives are being achieved.
4.	If quality objectives are not being achieved, document the executive’s answer to the question: “What actions are being taken to achieve the quality objectives?”
a.	Attach documents evidencing that these actions are being taken.
5.	If quality objectives are being achieved, document the executive’s answer to the question: “How are the quality results reviewed for opportunities for continual improvement?”

EOT
}

tasks << {
:name => "Management Representative",
:instructions => <<EOT
1.	Document each executive’s answer to the question: “Who is the QMS Management Representative (MR)?  Does the MR’s position designate him/her as a member of management?” (If there is no MR, report this finding to senior management for immediate corrective action.)
2.	Document each executive’s answer to the question: “How does the MR ensure the promotion of awareness of customer requirements throughout the organization?”
a.	Attach documents evidencing that the MR’s roles and responsibilities are clearly defined and documented in the QMS.
i.	Verify the documents clearly state that the MR’s responsibilities include implementation and maintenance of the quality management system, as well as communicating information to top management about the effectiveness of the quality management system.

EOT
}


template.tasks = tasks.to_json
template.save!
