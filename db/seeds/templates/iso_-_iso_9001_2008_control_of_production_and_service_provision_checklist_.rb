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
<ol><li>1. Identify the process owner who can properly describe the phases and quality metrics of the Production and Service Process (P&amp;S). In the workspace below, provide the process owner’s name, title, date interviewed and state why this individual is qualified to participate in the P&amp;S quality management review.<br></li><li>Document the process owner’s identification of the organization’s P&amp;S Processes.<br></li><li>Document the P&amp;S process owner’s verbal answers to the following questions:<br><ol start="1" style="list-style-type: lower-alpha;"><li>How is production scheduled to ensure that ship dates or delivery dates are met?<br></li><li>Is the schedule appropriate/realistic or does meeting it often require extraordinary measures?<br></li><li>Describe the process for releasing and shipping product to ensure that only acceptable product is shipped to the correct customer.<br></li><li>How are nonconforming incoming materials, in-process materials, and final products controlled to prevent them from being shipped or further processed without defined approval?</li></ol></li></ol>
EOT
}

tasks << {
:name => "P&S Metrics",
:instructions => <<EOT
<ol><li>Document the P&amp;S process owner’s verbal answers to the following questions:<br><ol start="1" style="list-style-type: lower-alpha;"><li>What metrics do you use to evaluate the effectiveness of the P&amp;S process(es)? For example, defect rates; scrap rates; waste and rework; improvement in on-time delivery, etc.<br><ol start="1" style="list-style-type: lower-roman;"><li>Who monitors these metrics?<br></li><li>How is each metric evaluated?<br></li></ol></li><li>Do you have goals and objectives established for each metric?<br></li><li>Are the goals and objectives for each being achieved?<br><ol start="1" style="list-style-type: lower-roman;"><li>Attach documents evidencing whether or not these goals are being achieved.<br></li></ol></li><li>If goals are NOT being met, ask: “What actions are being taken to improve the process?”<br></li><li>If goals ARE being met, ask: “How are the processes reviewed for opportunities of continual improvement?”<br></li><li>Does your organization have any processes in which the final product cannot be verified by monitoring and measurement?<br><ol start="1" style="list-style-type: lower-roman;"><li>If the answer is, “Yes,” go to Task 3, Verification of Processes for P&amp;S Provision.<br></li><li>If the answer is, “No,” proceed to Task 4</li></ol></li></ol></li></ol>
EOT
}

tasks << {
:name => "Verification of Processes for P&S Provision",
:instructions => <<EOT
<ol><li>What are the procedures; methods; and resources used to verify that the planned results for the product or service (that cannot be verified directly by monitoring and measurement) have been achieved?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Attach documents evidencing approval of the verification process, equipment and personnel qualifications;<br></li><li>Attach appropriate records of process verification showing the achievement of planned results;<br></li><li>Attach appropriate records demonstrating the ongoing maintenance of the verification capability;<br></li><li>If the verification process was changed, attach documents evidencing the subsequent results were validated for consistency.</li></ol></li></ol>
EOT
}

tasks << {
:name => "Verification of Identification and Traceability",
:instructions => <<EOT
<ol><li>Are incoming materials, in-process materials, and final products clearly identified?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Sample components and products to verify conformance to identification requirements.<br></li></ol></li><li>Attach documents evidencing the traceability requirements for the organization.<br><ol start="1" style="list-style-type: lower-alpha;"><li>Verify that the traceability requirements are being met.<br></li></ol></li><li>How is the inspection and test status of components documented?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Sample records to verify conformance to specifications.</li></ol></li></ol>
EOT
}

tasks << {
:name => "Customer Property",
:instructions => <<EOT
<ol><li>What customer-supplied products, such as raw materials, in-process parts, dies, shipping containers, intellectual property, etc., does the organization receive, if any?<br><ol start="1" style="list-style-type: lower-alpha;"><li>If “None,” please note and proceed to Task 6.<br></li><li>If customer-supplied products are used by the organization, how are they inspected upon receipt to ensure that they are fit for use?<br></li><li>Attach documents demonstrating evidence that the customer-supplied products were inspected upon receipt and were in conformance with receiving inspection requirements.<br></li></ol></li><li>How are customer-supplied products protected and safeguarded to protect their fitness for use?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Attach documents demonstrating evidence that the customer-supplied products are being protected in conformance with the organization’s policy.<br></li></ol></li><li>What process is in place to notify customers of any problems associated with their property?</li></ol>
EOT
}

tasks << {
:name => "Preservation of Product",
:instructions => <<EOT
<ol><li>How are products handled and stored to protect their fitness for use?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Describe specific handling and storage issues within the organization.<br></li><li>Attach documents demonstrating whether or not products are handled and stored according to the organization’s approved procedures.<br></li></ol></li><li>Is the product packaged and labeled in a manner that meets customer requirements?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Observe product being packaged and determine if the correct procedures are being followed.</li></ol></li></ol>
EOT
}

tasks << {
:name => "P&S Process Customers",
:instructions => <<EOT
<ol><li>Interview any internal customers (such as warehousing, shipping, customer service etc.) of the P&amp;S Process and document from their perspective the effectiveness of the output of the P&amp;S Process.</li></ol>
EOT
}

tasks << {
:name => "P&S Process Responsibilities",
:instructions => <<EOT
<ol><li>Who participates in the P&amp;S Process? Document their positions/titles.<br></li><li>What are the responsibilities for each individual?<br></li><li>How is their authority defined and communicated?</li></ol>
EOT
}

tasks << {
:name => "P&S Process Competence",
:instructions => <<EOT
<ol><li>Has the organization defined the skills and knowledge (competence) required to perform the jobs in this process?<br></li><li>Is training provided to ensure that employees are competent? Describe the training.<br></li><li>Did the training include awareness of the importance of the employee’s activities in achieving the organization’s quality policy and objectives?<br></li><li>How is training evaluated for effectiveness?<br></li><li>Attach documents evidencing training records for employees new to the organization or the position. Be sure to obtain records for management, technical, and administrative personnel.</li></ol>
EOT
}

tasks << {
:name => "P&S Process Training Evaluation",
:instructions => <<EOT
<ol><li>Interview each new employee identified in Task 9-5 above and document his/her answer to the following questions:<br><ol start="1" style="list-style-type: lower-alpha;"><li>How would you rate the training process on a scale of 1 to 10, with 1 being unacceptable and 10 excellent?<br><ol start="1" style="list-style-type: lower-roman;"><li>If 8 or above, record the answer and this task is completed for this new employee.<br></li><li>If 7 or below, document the answers to Questions b and c below.<br></li></ol></li><li>What specific knowledge did you need that was not provided?<br><ol start="1" style="list-style-type: lower-roman;"><li>Verify that this specific training was, in fact, not provided.<br></li><li>Describe the knowledge areas the employee states need improvement.<br></li></ol></li><li>What additional training did you wish you had received?<br><ol start="1" style="list-style-type: lower-roman;"><li>Did lack of that training create a problem for you? If yes, please describe the problem and how additional training would have avoided/solved the problem.</li></ol></li></ol></li></ol>
EOT
}

tasks << {
:name => "P&S Process Information",
:instructions => <<EOT
<ol><li>What types of documents are used in the P&amp;S Process? (These may include procedures, work instructions, test methods, job descriptions, specifications, prints, check sheets, batch sheets, control plans, etc. and they may be in paper or electronic form.)<br><ol start="1" style="list-style-type: lower-alpha;"><li>Note which of these are external documents, such as customer drawings or supplier material/part specifications, and how they are identified as external documents.<br></li></ol></li><li>What is the revision control system for managing internal documents?<br><ol start="1" style="list-style-type: lower-alpha;"><li>What is the process for approving revisions?<br></li><li>How frequently are documents reviewed for adequacy?<br></li></ol></li><li>What is the control system for managing external documents?<br></li><li>Select a sampling of process participants and document each one’s answer to the following questions:<br><ol start="1" style="list-style-type: lower-alpha;"><li>Do the documents you use include the proper type and amount of information?<br></li><li>Are changes to the documents you use clearly identified?<br></li><li>Are there any problems with the documents you use?<br><ol start="1" style="list-style-type: lower-roman;"><li>Are they all legible?<br></li></ol></li><li>Do you get the documents you use when you need them?<br></li></ol></li><li>Note if you observe any obsolete or invalid documents in the area. Describe the situation.</li></ol>
EOT
}

tasks << {
:name => "P&S Process Infrastructure",
:instructions => <<EOT
<ol><li>What equipment, tools, parts, materials, hardware, or software are required for this process?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Is equipment adequately maintained?<br><ol start="1" style="list-style-type: lower-roman;"><li>Are there any repetitive equipment problems?<br></li></ol></li><li>Are the tools adequate for the process?<br></li><li>Are there any repetitive problems associated with any materials used in the process?<br></li><li>Are materials available when needed?<br></li><li>Is the hardware and software used in the process adequate to meet the needs of process participants?<br></li></ol></li><li>Is the work environment suitable for the process?</li></ol>
EOT
}

tasks << {
:name => "P&S Process Records",
:instructions => <<EOT
<ol><li>What records are generated by the P&amp;S Process?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Are the records legible, readily retrievable, and stored in a way that protects their fitness for use?<br></li></ol></li><li>Have responsibilities for record collection, maintenance and access been clearly defined and documented?<br></li><li>Verify that electronic records are appropriately backed-up and can be restored, if necessary.<br></li><li>What are the performance indicators used to demonstrate effective implementation of the record control process? How are they tracked for continual improvement?<br></li><li>Is there a plan for record disposition?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Are records disposed of in accordance with the plan?</li></ol></li></ol>
EOT
}

tasks << {
:name => "Communication of Quality Policy Statement and Objectives",
:instructions => <<EOT
<ol><li>For a sampling of employees responsible for the P&amp;S Process:<br><ol start="1" style="list-style-type: lower-alpha;"><li>Document their name, position and answers to the following open-ended questions;<br><ol start="1" style="list-style-type: lower-roman;"><li>Are you aware of the quality policy?<br></li><li>Can you state the key concepts in your own words?<br></li><li>How does the quality policy relate to your job?<br></li><li>What quality objectives have been established for this process?<br></li><li>Is the organization achieving these quality objectives?<br></li><li>How does what you do impact whether or not the organization will meet these quality objectives?<br></li></ol></li></ol></li><li>Summarize your evaluation of whether or not the quality goals and objectives have been adequately communicated to the personnel responsible for P&amp;S Process.</li></ol>
EOT
}


template.tasks = tasks.to_json
template.save!
