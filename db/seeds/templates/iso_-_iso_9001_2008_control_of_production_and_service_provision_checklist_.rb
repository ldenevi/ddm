# encoding: UTF-8
puts "Creating ISO 9001:2008 – Control of Production and Service Provision Checklist  ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('ISO'),
                               :full_name => 'ISO 9001:2008 Quality Management System Requirements',
                               :display_name => 'ISO 9001',
                               :description => 'ISO 9001:2008 sets out the criteria for a quality management system.',
                               :regulatory_review_name => 'ISO 9001:2008 – Control of Production and Service Provision Checklist ',
                               :frequency => 'Annual'.force_encoding('UTF-8'),                            
                               :objectives => "The organization must have in place a suitable process to ensure the effective planning, operation and control of production and service activities.  Read through all the task instructions to understand how to document this review.  Then identify and interview the executive(s) responsible for evaluating the criteria and methods used to ensure the effective operation and control of the production and service process.  Note any exceptions to the organization’s QMS policy and report to the appropriate person for corrective action.  When you identify methods to improve a process, document your findings and forward to the appropriate person.".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "Production and Service Process",
:instructions => <<EOT
1.	Identify the process owner who can properly describe the phases and quality metrics of the Production and Service Process (P&S).  In the workspace below, provide the process owner’s name, title, date interviewed and state why this individual is qualified to participate in the P&S quality management review.  
2.	Document the process owner’s identification of the organization’s P&S Processes.
3.	Document the P&S process owner’s verbal answers to the following questions:
a.	How is production scheduled to ensure that ship dates or delivery dates are met?
b.	Is the schedule appropriate/realistic or does meeting it often require extraordinary measures?
c.	Describe the process for releasing and shipping product to ensure that only acceptable product is shipped to the correct customer.
d.	How are nonconforming incoming materials, in-process materials, and final products controlled to prevent them from being shipped or further processed without defined approval?

EOT
}

tasks << {
:name => "P&S Metrics",
:instructions => <<EOT
1.	Document the P&S process owner’s verbal answers to the following questions:
a.	What metrics do you use to evaluate the effectiveness of the P&S process(es)?  For example, defect rates; scrap rates; waste and rework; improvement in on-time delivery, etc.
i.	Who monitors these metrics? 
ii.	How is each metric evaluated?
b.	Do you have goals and objectives established for each metric?
c.	Are the goals and objectives for each being achieved? 
i.	Attach documents evidencing whether or not these goals are being achieved.
e.	If goals are NOT being met, ask: “What actions are being taken to improve the process?”
f.	If goals ARE being met, ask: “How are the processes reviewed for opportunities of continual improvement?”
g.	Does your organization have any processes in which the final product cannot be verified by monitoring and measurement?
i.	If the answer is, “Yes,” go to Task 3, Verification of Processes for P&S Provision.
ii.	If the answer is, “No,” proceed to Task 4

EOT
}

tasks << {
:name => "Verification of Processes for P&S Provision",
:instructions => <<EOT
1.	What are the procedures; methods; and resources used to verify that the planned results for the product or service (that cannot be verified directly by monitoring and measurement) have been achieved?
a.	Attach documents evidencing approval of the verification process, equipment and personnel qualifications;
b.	Attach appropriate records of process verification showing the achievement of planned results;
c.	 Attach appropriate records demonstrating the ongoing maintenance of the verification capability;
d.	If the verification process was changed, attach documents evidencing the subsequent results were validated for consistency.

EOT
}

tasks << {
:name => "Verification of Identification and Traceability",
:instructions => <<EOT
1.	Are incoming materials, in-process materials, and final products clearly identified?
a.	Sample components and products to verify conformance to identification requirements.
2.	Attach documents evidencing the traceability requirements for the organization.
a.	Verify that the traceability requirements are being met.
3.	How is the inspection and test status of components documented?
a.	Sample records to verify conformance to specifications.

EOT
}

tasks << {
:name => "Customer Property",
:instructions => <<EOT
1.	What customer-supplied products, such as raw materials, in-process parts, dies, shipping containers, intellectual property, etc., does the organization receive, if any?
a.	If “None,” please note and proceed to Task 6.
b.	If customer-supplied products are used by the organization, how are they inspected upon receipt to ensure that they are fit for use?
c.	Attach documents demonstrating evidence that the customer-supplied products were inspected upon receipt and were in conformance with receiving inspection requirements.
2.	How are customer-supplied products protected and safeguarded to protect their fitness for use?
a.	Attach documents demonstrating evidence that the customer-supplied products are being protected in conformance with the organization’s policy.
3.	What process is in place to notify customers of any problems associated with their property?

EOT
}

tasks << {
:name => "Preservation of Product",
:instructions => <<EOT
1.	How are products handled and stored to protect their fitness for use? 
a.	Describe specific handling and storage issues within the organization.
b.	Attach documents demonstrating whether or not products are handled and stored according to the organization’s approved procedures.
2.	Is the product packaged and labeled in a manner that meets customer requirements?
a.	Observe product being packaged and determine if the correct procedures are being followed.

EOT
}

tasks << {
:name => "P&S Process Customers",
:instructions => <<EOT
1.	Interview any internal customers (such as warehousing, shipping, customer service etc.) of the P&S Process and document from their perspective the effectiveness of the output of the P&S Process.
EOT
}

tasks << {
:name => "P&S Process Responsibilities",
:instructions => <<EOT
1.	Who participates in the P&S Process?  Document their positions/titles.
2.	What are the responsibilities for each individual?
3.	How is their authority defined and communicated?

EOT
}

tasks << {
:name => "P&S Process Competence",
:instructions => <<EOT
1.	Has the organization defined the skills and knowledge (competence) required to perform the jobs in this process?
2.	Is training provided to ensure that employees are competent? Describe the training.
3.	Did the training include awareness of the importance of the employee’s activities in achieving the organization’s quality policy and objectives?
4.	How is training evaluated for effectiveness?
5.	Attach documents evidencing training records for employees new to the organization or the position.  Be sure to obtain records for management, technical, and administrative personnel.

EOT
}

tasks << {
:name => "P&S Process Training Evaluation",
:instructions => <<EOT
1.	Interview each new employee identified in Task 9-5 above and document his/her answer to the following questions:
a.	How would you rate the training process on a scale of 1 to 10, with 1 being unacceptable and 10 excellent?
i.	If 8 or above, record the answer and this task is completed for this new employee.
ii.	If 7 or below, document the answers to Questions b and c below.  
b.	What specific knowledge did you need that was not provided?  
i.	Verify that this specific training was, in fact, not provided.  
ii.	Describe the knowledge areas the employee states need improvement.
c.	What additional training did you wish you had received?  
i.	Did lack of that training create a problem for you?  If yes, please describe the problem and how additional training would have avoided/solved the problem.

EOT
}

tasks << {
:name => "P&S Process Information",
:instructions => <<EOT
1.	What types of documents are used in the P&S Process? (These may include procedures, work instructions, test methods, job descriptions, specifications, prints, check sheets, batch sheets, control plans, etc. and they may be in paper or electronic form.)
a.	Note which of these are external documents, such as customer drawings or supplier material/part specifications, and how they are identified as external documents.
2.	What is the revision control system for managing internal documents?
a.	What is the process for approving revisions?
b.	How frequently are documents reviewed for adequacy?
3.	What is the control system for managing external documents?
4.	Select a sampling of process participants and document each one’s answer to the following questions:
a.	Do the documents you use include the proper type and amount of information?
b.	Are changes to the documents you use clearly identified?
c.	Are there any problems with the documents you use?
i.	Are they all legible?
d.	Do you get the documents you use when you need them?
5.	Note if you observe any obsolete or invalid documents in the area.  Describe the situation.

EOT
}

tasks << {
:name => "P&S Process Infrastructure",
:instructions => <<EOT
1.	What equipment, tools, parts, materials, hardware, or software are required for this process?
a.	Is equipment adequately maintained? 
i.	Are there any repetitive equipment problems?
b.	Are the tools adequate for the process?
c.	Are there any repetitive problems associated with any materials used in the process?
d.	Are materials available when needed?
e.	Is the hardware and software used in the process adequate to meet the needs of process participants?
2.	Is the work environment suitable for the process?

EOT
}

tasks << {
:name => "P&S Process Records",
:instructions => <<EOT
1.	What records are generated by the P&S Process?
a.	Are the records legible, readily retrievable, and stored in a way that protects their fitness for use?
2.	Have responsibilities for record collection, maintenance and access been clearly defined and documented?
3.	Verify that electronic records are appropriately backed-up and can be restored, if necessary.
4.	What are the performance indicators used to demonstrate effective implementation of the record control process? How are they tracked for continual improvement?
5.	Is there a plan for record disposition? 
a.	Are records disposed of in accordance with the plan?

EOT
}

tasks << {
:name => "Communication of Quality Policy Statement and Objectives",
:instructions => <<EOT
1.	For a sampling of employees responsible for the P&S Process:
a.	Document their name, position and answers to the following open-ended questions;
a.	Are you aware of the quality policy?
b.	Can you state the key concepts in your own words?
c.	How does the quality policy relate to your job?
d.	What quality objectives have been established for this process?
e.	Is the organization achieving these quality objectives?
f.	How does what you do impact whether or not the organization will meet these quality objectives?
2.	Summarize your evaluation of whether or not the quality goals and objectives have been adequately communicated to the personnel responsible for P&S Process.

EOT
}


template.tasks = tasks.to_json
template.save!
