# encoding: UTF-8
puts "Creating ISO 9001:2008 – Control of Nonconforming Product Checklist  ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('ISO'),
                               :full_name => 'ISO 9001:2008 Quality Management System Requirements',
                               :display_name => 'ISO 9001',
                               :description => 'ISO 9001:2008 sets out the criteria for a quality management system.',
                               :regulatory_review_name => 'ISO 9001:2008 – Control of Nonconforming Product Checklist ',
                               :frequency => 'Annual'.force_encoding('UTF-8'),                            
                               :objectives => "The organization must have in place a suitable process to identify and control nonconforming products to prevent unintended use or delivery.  Read through all the task instructions to understand how to document this review.  Then identify and interview the executive(s) responsible for the corrective actions such as: eliminating the nonconformity; authorize the nonconforming product’s use or take action to prevent its original intended use or application.  Note any exceptions to the organization’s QMS policy and report to the appropriate person for corrective action.  When you identify methods to improve a process, document your findings and forward to the appropriate person.".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "Control of Nonconforming Product (CNP)",
:instructions => <<EOT
<ol><li>Identify the process owner who can properly describe the process and quality metrics for the Control of Nonconforming Product (CNP). In the workspace below, provide the process owner’s name, title, date interviewed and state why this individual is qualified to participate in the CNP quality management review.<br></li><li>Document the process owner’s description of your organization’s CNP Process. How are nonconforming incoming materials, in-process materials, and final products controlled to prevent them from being shipped or further processed without required approval?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Include a description of how the identification of nonconforming product triggers a Corrective Action.<br></li><li>Include a description of how the identification of nonconforming product is used as the basis for initiating a Preventive Action.</li></ol></li></ol>

EOT
}

tasks << {
:name => "CNP Metrics",
:instructions => <<EOT
<ol><li>Document the CNP process owner’s verbal answers to the following questions:<br><ol start="1" style="list-style-type: lower-alpha;"><li>What metrics do you use to evaluate the effectiveness of the CNP process? For example: reduction in cycle time to evaluate and dispose of nonconforming product; reduced errors in preventing unintended use or delivery; improved alternate use of nonconforming product and cost recovery; etc.<br><ol start="1" style="list-style-type: lower-roman;"><li>Who monitors these metrics?<br></li><li>How is each metric evaluated?<br></li></ol></li><li>Do you have goals and objectives established for each metric?<br></li><li>Are the goals and objectives for each being achieved?<br><ol start="1" style="list-style-type: lower-roman;"><li>Attach documents evidencing whether or not these goals are being achieved.<br></li></ol></li><li>If goals are NOT being met, ask: “What actions are being taken to improve the process?”<br></li><li>If goals ARE being met, ask: “How are the processes reviewed for opportunities of continual improvement?”</li></ol></li></ol>

EOT
}

tasks << {
:name => "CNP Process Verification",
:instructions => <<EOT
<ol><li>Select a sampling of Corrective Action Requests initiated by the identification of nonconforming products and evaluate the effectiveness of the corrective action process based upon the following criteria:<br><ol start="1" style="list-style-type: lower-alpha;"><li>Was the cause of the problem identified?<br></li><li>Was action taken to eliminate the cause?<br></li><li>Is there evidence that the corrective action was effective?<br></li><li>If applicable, were any documents updated as a result of the corrective action?<br></li><li>Was the corrective action completed in a timely manner?<br></li></ol></li><li>Walk through production and storage areas and verify conformance with documented procedures. Record any exceptions.<br></li><li>Visit production and storage areas to verify that any nonconforming product is suitably identified and controlled per the procedure. Record any exceptions.<br></li><li>If nonconforming product was shipped without a customer concession, confirm that immediate action was taken to reduce the consequential effect of the nonconformity.<br></li><li>Attach documentation verifying the product disposition was made by the authorized personnel.</li></ol>

EOT
}

tasks << {
:name => "CNP Process Customers",
:instructions => <<EOT
<ol><li>Interview any internal customers (such as manufacturing, purchasing, customer service, shipping, etc.) of the CNP Process and document from their perspective the effectiveness of the output of the CNP Process.<br><ol start="1" style="list-style-type: lower-alpha;"><li>Are manufacturing personnel receiving adequate information to run the manufacturing process?<br></li><li>Are purchasing personnel receiving adequate information (on raw material specs, and so on) in time to reject unacceptable materials from qualified suppliers?<br></li><li>If nonconforming product was detected after shipment, was customer service notified and appropriate action taken?<br></li></ol></li><li>Confirm that prior to shipping nonconforming products the organization received concession or deviation authorizations in writing from the customer.</li></ol>

EOT
}

tasks << {
:name => "CNP Process Responsibilities",
:instructions => <<EOT
<ol><li>Who participates in the CNP Process? Document their positions/titles.<br></li><li>What are the responsibilities for each individual?<br></li><li>Who has the authority to approve or disposition nonconforming parts and materials?<br></li><li>How is their authority defined and communicated?</li></ol>

EOT
}

tasks << {
:name => "CNP Process Competence",
:instructions => <<EOT
<ol><li>Has the organization defined the skills and knowledge (competence) required to perform the jobs in this process?<br></li><li>Is training provided to ensure that employees are competent? Describe the training.<br></li><li>Did the training include awareness of the importance of the employee’s activities in achieving the organization’s quality policy and objectives?<br></li><li>How is training evaluated for effectiveness?<br></li><li>Attach documents evidencing training records for employees new to the organization or the position. Be sure to obtain records for management, technical, and administrative personnel.</li></ol>

EOT
}

tasks << {
:name => "CNP Process Training Evaluation",
:instructions => <<EOT
<ol><li>Interview each new employee identified in Task 6-5 above and document his/her answer to the following questions:<br><ol start="1" style="list-style-type: lower-alpha;"><li>How would you rate the training process on a scale of 1 to 10, with 1 being unacceptable and 10 excellent?<br><ol start="1" style="list-style-type: lower-roman;"><li>If 8 or above, record the answer and this task is completed for this new employee.<br></li><li>If 7 or below, document the answers to Questions b and c below.<br></li></ol></li><li>What specific knowledge did you need that was not provided?<br><ol start="1" style="list-style-type: lower-roman;"><li>Verify that this specific training was, in fact, not provided.<br></li><li>Describe the knowledge areas the employee states need improvement.<br></li></ol></li><li>What additional training did you wish you had received?<br><ol start="1" style="list-style-type: lower-roman;"><li>Did lack of that training create a problem for you? If yes, please describe the problem and how additional training would have avoided/solved the problem.</li></ol></li></ol></li></ol>

EOT
}


template.tasks = tasks.to_json
template.save!
