# encoding: UTF-8
puts "Creating ISO 9001:2008 – Control of Purchasing Checklist  ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('ISO'),
                               :full_name => '',
                               :display_name => 'ISO 9001',
                               :description => 'ISO 9001:2008 sets out the criteria for a quality management system.',
                               :regulatory_review_name => 'ISO 9001:2008 – Control of Purchasing Checklist ',
                               :frequency => 'Annual'.force_encoding('UTF-8'),                            
                               :objectives => "The organization must have in place quality requirements to control purchased product, suppliers and the buying process.  Read through all the task instructions to understand how to document this review.  Then identify and interview the executive(s) responsible for evaluating the criteria and methods used to ensure the effective operation and control of the purchasing process.  Note any exceptions to the organization’s QMS policy and report to the appropriate person for corrective action.  When you identify methods to improve a process, document your findings and forward to the appropriate person.".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "Purchasing Process",
:instructions => <<EOT
<ol><li>Identify the process owner who can properly describe the phases and quality metrics of the Purchasing Process. In the workspace below, provide the process owner’s name, title, date interviewed and state why this individual is qualified to participate in the Purchasing quality management review.<br></li><li>Document the process owner’s description of the organization’s Purchasing Process.<br><ol start="1" style="list-style-type: lower-alpha;"><li>Be sure to include a description of the organization’s receiving inspection process.</li></ol></li></ol>

EOT
}

tasks << {
:name => "Purchasing Metrics",
:instructions => <<EOT
<ol><li>Document the Purchasing process owner’s verbal answers to the following questions:<br><ol start="1" style="list-style-type: lower-alpha;"><li>What metrics do you use to evaluate the effectiveness of the Purchasing process? For example, reduction of defects in supplied product; scrap; waste and rework; improvement in on-time delivery, service, cost; reduction in supplier - quote review cycle time; contract award cycle time; purchase order-entry errors and omissions; receiving errors &amp; omissions; etc.<br><ol start="1" style="list-style-type: lower-roman;"><li>Who monitors these metrics?<br></li><li>How is each metric evaluated?<br></li></ol></li><li>Do you have goals and objectives established for each metric?<br></li><li>Are the goals and objectives for each being achieved?<br><ol start="1" style="list-style-type: lower-roman;"><li>Attach documents evidencing whether or not these goals are being achieved.<br></li></ol></li><li>If goals are NOT being met, ask: “What actions are being taken to improve the process?”<br></li><li>If goals ARE being met, ask: “How are the processes reviewed for opportunities of continual improvement?”</li></ol></li></ol>

EOT
}

tasks << {
:name => "New Supplier Qualification",
:instructions => <<EOT
<ol><li>Are the organization’s requirements for qualifying new suppliers clearly defined and documented?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Attach the documents defining the qualification requirements for new suppliers.<br></li></ol></li><li>Review the records of new suppliers who have been approved in the past year and verify whether or not they met the qualification requirements.</li></ol>

EOT
}

tasks << {
:name => "Supplier Re-evaluation",
:instructions => <<EOT
<ol><li>Are the organization’s requirements for re-evaluating current suppliers clearly defined and documented?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Attach the documents defining the re-evaluation process and qualification requirements for existing suppliers.<br></li></ol></li><li>Review the records of suppliers who have been re-evaluated in the past year and verify whether or not they met the qualification requirements.<br><ol start="1" style="list-style-type: lower-alpha;"><li>Where records show evidence of poor performance, ensure that corrective action has been initiated.</li></ol></li></ol>

EOT
}

tasks << {
:name => "Verify Purchase Order Quality",
:instructions => <<EOT
<ol><li>Select a random sampling of purchase orders and verify:<br><ol start="1" style="list-style-type: lower-alpha;"><li>Was the supplier on an approved supplier list? Identify the list.<br><ol start="1" style="list-style-type: lower-roman;"><li>Did that supplier meet the organization’s selection and evaluation criteria?<br></li></ol></li><li>Were the products or services ordered clearly defined along with required delivery dates, any required quality system standards, applicable approval requirements, and personnel qualification, as applicable?<br></li><li>Were the Purchase Orders reviewed to ensure their adequacy prior to being issued?</li></ol></li></ol>

EOT
}

tasks << {
:name => "Verification of Purchased Product",
:instructions => <<EOT
<ol><li>Are the organization’s requirements for receiving inspection clearly defined and documented?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Attach the documents defining the qualification requirements for receiving inspection.<br></li></ol></li><li>Select a sampling of incoming materials and verify whether the inspection requirements were met or not.<br></li><li>If incoming materials did not meet specifications, how were they controlled to ensure they were not used until receiving proper authorization?</li></ol>

EOT
}

tasks << {
:name => "Purchasing Customers",
:instructions => <<EOT
<ol><li>Interview any internal customers (such as manufacturing, shipping, etc.) of the Purchasing Process and document from their perspective the effectiveness of the output of the Purchasing Process.<br><ol start="1" style="list-style-type: lower-alpha;"><li>For example, are operations personnel receiving appropriate materials when needed to run the manufacturing process?</li></ol></li></ol>

EOT
}

tasks << {
:name => "Purchasing Process Responsibilities",
:instructions => <<EOT
<ol><li>Who participates in the Purchasing Process? Document their positions/titles.<br></li><li>What are the responsibilities for each individual?<br></li><li>How is their authority defined and communicated?</li></ol>

EOT
}

tasks << {
:name => "Purchasing Process Competence",
:instructions => <<EOT
<ol><li>Has the organization defined the skills and knowledge (competence) required to perform the jobs in this process?<br></li><li>Is training provided to ensure that employees are competent? Describe the training.<br></li><li>Did the training include awareness of the importance of the employee’s activities in achieving the organization’s quality policy and objectives?<br></li><li>How is training evaluated for effectiveness?<br></li><li>Attach documents evidencing training records for employees new to the organization or the position. Be sure to obtain records for management, technical, and administrative personnel.</li></ol>

EOT
}

tasks << {
:name => "Purchasing Process Training Evaluation",
:instructions => <<EOT
<ol><li>Interview each new employee identified in Task 9-5 above and document his/her answer to the following questions:<br><ol start="1" style="list-style-type: lower-alpha;"><li>How would you rate the training process on a scale of 1 to 10, with 1 being unacceptable and 10 excellent?<br><ol start="1" style="list-style-type: lower-roman;"><li>If 8 or above, record the answer and this task is completed for this new employee.<br></li><li>If 7 or below, document the answers to Questions b and c below.<br></li></ol></li><li>What specific knowledge did you need that was not provided?<br><ol start="1" style="list-style-type: lower-roman;"><li>Verify that this specific training was, in fact, not provided.<br></li><li>Describe the knowledge areas the employee states need improvement.<br></li></ol></li><li>What additional training did you wish you had received?<br><ol start="1" style="list-style-type: lower-roman;"><li>Did lack of that training create a problem for you? If yes, please describe the problem and how additional training would have avoided/solved the problem.</li></ol></li></ol></li></ol>

EOT
}

tasks << {
:name => "Purchasing Process Information",
:instructions => <<EOT
<ol><li>What types of documents are used in the Purchasing Process? (These may include procedures, work instructions, test methods, job descriptions, specifications, prints, check sheets, batch sheets, control plans, etc. and they may be in paper or electronic form.)<br><ol start="1" style="list-style-type: lower-alpha;"><li>Note which of these are external documents, such as customer drawings or supplier material/part specifications, and how they are identified as external documents.<br></li></ol></li><li>What is the revision control system for managing internal documents?<br><ol start="1" style="list-style-type: lower-alpha;"><li>What is the process for approving revisions?<br></li><li>How frequently are documents reviewed for adequacy?<br></li></ol></li><li>What is the control system for managing external documents?<br></li><li>Select a sampling of process participants and document each one’s answer to the following questions:<br><ol start="1" style="list-style-type: lower-alpha;"><li>Do the documents you use include the proper type and amount of information?<br></li><li>Are changes to the documents you use clearly identified?<br></li><li>Are there any problems with the documents you use? <br><ol start="1" style="list-style-type: lower-roman;"><li>Are they all legible?<br></li></ol></li><li>Do you get the documents you use when you need them? <br></li></ol></li><li>Note if you observe any obsolete or invalid documents in the area. Describe the situation.</li></ol>

EOT
}

tasks << {
:name => "Purchasing Process Infrastructure",
:instructions => <<EOT
<ol><li>What equipment, tools, parts, materials, hardware, or software are required for this process?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Is equipment adequately maintained?<br><ol start="1" style="list-style-type: lower-roman;"><li>Are there any repetitive equipment problems?<br></li></ol></li><li>Are the tools adequate for the process?<br></li><li>Are there any repetitive problems associated with any materials used in the process?<br></li><li>Are materials available when needed?<br></li><li>Is the hardware and software used in the process adequate to meet the needs of process participants?<br></li></ol></li><li>Is the work environment suitable for the process?</li></ol>

EOT
}

tasks << {
:name => "Purchasing Process Records",
:instructions => <<EOT
<ol><li>What records are generated by the Purchasing Process?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Are the records legible, readily retrievable, and stored in a way that protects their fitness for use?<br></li></ol></li><li>Have responsibilities for record collection, maintenance and access been clearly defined and documented?<br></li><li>Verify that electronic records are appropriately backed-up and can be restored, if necessary.<br></li><li>What are the performance indicators used to demonstrate effective implementation of the record control process? How are they tracked for continual improvement?<br></li><li>Is there a plan for record disposition?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Are records disposed of in accordance with the plan?<br></li></ol></li></ol>

EOT
}

tasks << {
:name => "Communication of Quality Policy Statement and Objectives",
:instructions => <<EOT
<ol><li>For a sampling of employees responsible for the Purchasing Process:<br><ol start="1" style="list-style-type: lower-alpha;"><li>Document their name, position and answers to the following open-ended questions; <br><ol start="1" style="list-style-type: lower-alpha;"><li>Are you aware of the quality policy?<br></li><li>Can you state the key concepts in your own words?<br></li><li>How does the quality policy relate to your job?<br></li><li>What quality objectives have been established for this process?<br></li><li>Is the organization achieving these quality objectives?<br></li><li>How does what you do impact whether or not the organization will meet these quality objectives?<br></li></ol></li></ol></li><li>Summarize your evaluation of whether or not the quality goals and objectives have been adequately communicated to the personnel responsible for the Purchasing Process.</li></ol>

EOT
}


template.tasks = tasks.to_json
template.save!
