# encoding: UTF-8
puts "Creating ISO 9001:2008 - Planning for New Products and Processes Checklist ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('ISO'),
                               :full_name => 'ISO 9001:2008 Quality Management System Requirements',
                               :display_name => 'ISO 9001',
                               :description => 'ISO 9001:2008 sets out the criteria for a quality management system.',
                               :regulatory_review_name => 'ISO 9001:2008 - Planning for New Products and Processes Checklist',
                               :frequency => 'Annual'.force_encoding('UTF-8'),                            
                               :objectives => "The organization must have in place processes needed for product realization.  Read through all the task instructions to understand how to document this review.  Then identify and interview the executive(s) responsible for defining new products and processes that meet customers' requirements.  Note any exceptions to the organization's QMS policy and report to the appropriate person for corrective action.  When you identify methods to improve a process, document your findings and forward to the appropriate person.".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "New Products and Processes (NPP)",
:instructions => <<EOT
<ol><li>Identify the process owner who can properly describe how the organization defines and documents customer requirements for new products. In the workspace below, provide the process owner's name, title, date interviewed and state why this individual is qualified to participate in the Purchasing quality management review.<br></li><li>Document the process owner's description of the organization's Product Realization Process.</li></ol>

EOT
}

tasks << {
:name => "NPP Metrics",
:instructions => <<EOT
<ol><li>Document the NPP process owner's verbal answers to the following questions:<br><ol start="1" style="list-style-type: lower-alpha;"><li>What metrics do you use to evaluate the effectiveness of the NPP process? For example, productivity; reduction of cycle time, errors, omissions and failures, on-time delivery, etc.<br><ol start="1" style="list-style-type: lower-roman;"><li>Who monitors these metrics?<br></li><li>How is each metric evaluated? <br></li></ol></li><li>Do you have goals and objectives established for each metric?<br></li><li>Are the goals and objectives for each being achieved?<br><ol start="1" style="list-style-type: lower-roman;"><li>Attach documents evidencing whether or not these goals are being achieved.<br></li></ol></li><li>If goals are NOT being met, ask: "What actions are being taken to improve the process?"<br></li><li>If goals ARE being met, ask: "How are the processes reviewed for opportunities of continual improvement?"</li></ol></li></ol>

EOT
}

tasks << {
:name => "NPP Customer Requirements",
:instructions => <<EOT
<ol><li>Describe how your organization defines and documents customer requirements.<br><ol start="1" style="list-style-type: lower-alpha;"><li>Attach the documents defining the customer requirements for new products.<br></li></ol></li><li>Does documentation (for example, customer contracts, RFQs, RFPs, product specifications, packaging standards, orders, and so on) clearly and adequately define customer requirements including delivery and post-delivery requirements?<br></li><li>Do defined requirements include product-related statutory and regulatory requirements and any other requirement not necessarily stated by the customer but required for the product's known and intended use?<br></li><li>How are changes to customer requirements reviewed?<br><ol start="1" style="list-style-type: lower-alpha;"><li>By whom?<br></li><li>What records are maintained?<br></li><li>How are affected employees</li></ol></li></ol>

EOT
}

tasks << {
:name => "NPP Verification",
:instructions => <<EOT
<ol><li>Select a random sampling of new products or processes and verify the following:<br><ol start="1" style="list-style-type: lower-alpha;"><li>Were product or service requirements and quality objectives defined?<br></li><li>Did your organization verify that it had the capability of meeting the customers' requirements prior to accepting the order? Who was responsible?<br></li><li>Were current processes, documentation, and resources evaluated to ensure that they were suitable for the new product or process?<br></li><li>Were verification, validation, inspection, and test requirements defined? Did they include acceptance criteria?<br></li><li>Were any new records identified that would be necessary for these products, processes, or projects? If yes, please list.<br></li><li>If your organization could not meet the customer's requirements - including ship date - or if requirements on the order are difference from those on the contract, how was that resolved with the customer? By whom? What written records were kept? (Pull records to verify conformance.)</li></ol></li></ol>

EOT
}

tasks << {
:name => "NPP Customer Communications",
:instructions => <<EOT
<ol><li>Has the organization established effective arrangements for communications with customers regarding the following:<br><ol start="1" style="list-style-type: lower-alpha;"><li>New product information;<br></li><li>Inquires, contracts and order handling;<br></li><li>Customer feedback - including complaints;<br></li><li>Has the complaint file been reviewed for repetitive complaints? If repetitive complaints were found, was corrective action taken?</li></ol></li></ol>

EOT
}

tasks << {
:name => "NPP Customers",
:instructions => <<EOT
<ol><li>1. Interview any internal customers (such as manufacturing, shipping, etc.) of the NPP Process and document from their perspective the effectiveness of the output of the NPP Process.<br><ol start="1" style="list-style-type: lower-alpha;"><li>For example, are operations personnel receiving appropriate materials when needed to run the manufacturing process?<br></li><li>For example, are shipping personnel receiving the right packaging and customer labeling instructions?</li></ol></li></ol>

EOT
}

tasks << {
:name => "NPP Process Responsibilities",
:instructions => <<EOT
<ol><li>Who participates in the NPP Process? Document their positions/titles.<br></li><li>What are the responsibilities for each individual?<br></li><li>How is their authority defined and communicated?</li></ol>

EOT
}

tasks << {
:name => "NP Process Competence",
:instructions => <<EOT
<ol><li>Has the organization defined the skills and knowledge (competence) required to perform the jobs in this process?<br></li><li>Is training provided to ensure that employees are competent? Describe the training.<br></li><li>Did the training include awareness of the importance of the employee's activities in achieving the organization's quality policy and objectives?<br></li><li>How is training evaluated for effectiveness?<br></li><li>Attach documents evidencing training records for employees new to the organization or the position. Be sure to obtain records for management, technical, and administrative personnel.</li></ol>

EOT
}

tasks << {
:name => "NPP Process Training Evaluation",
:instructions => <<EOT
<ol><li>Interview each new employee identified in Task 8-5 above and document his/her answer to the following questions:<br><ol start="1" style="list-style-type: lower-alpha;"><li>How would you rate the training process on a scale of 1 to 10, with 1 being unacceptable and 10 excellent?<br><ol start="1" style="list-style-type: lower-roman;"><li>If 8 or above, record the answer and this task is completed for this new employee.<br></li><li>If 7 or below, document the answers to Questions b and c below.<br></li></ol></li><li>What specific knowledge did you need that was not provided?<br><ol start="1" style="list-style-type: lower-roman;"><li>Verify that this specific training was, in fact, not provided.<br></li><li>Describe the knowledge areas the employee states need improvement.<br></li></ol></li><li>What additional training did you wish you had received?<br><ol start="1" style="list-style-type: lower-roman;"><li>Did lack of that training create a problem for you? If yes, please describe the problem and how additional training would have avoided/solved the problem.</li></ol></li></ol></li></ol>

EOT
}

tasks << {
:name => "NPP Process Information",
:instructions => <<EOT
<ol><li>What types of documents are used in the NPP Process? (These may include procedures, work instructions, test methods, job descriptions, specifications, prints, check sheets, batch sheets, control plans, etc. and they may be in paper or electronic form.) <br><ol start="1" style="list-style-type: lower-alpha;"><li>Note which of these are external documents, such as customer drawings or supplier material/part specifications, and how they are identified as external documents.<br></li></ol></li><li>What is the revision control system for managing internal documents?<br><ol start="1" style="list-style-type: lower-alpha;"><li>What is the process for approving revisions?<br></li><li>How frequently are documents reviewed for adequacy?<br></li></ol></li><li>What is the control system for managing external documents?<br></li><li>Select a sampling of process participants and document each one's answer to the following questions:<br><ol start="1" style="list-style-type: lower-alpha;"><li>Do the documents you use include the proper type and amount of information?<br></li><li>Are changes to the documents you use clearly identified?<br></li><li>Are there any problems with the documents you use? <br><ol start="1" style="list-style-type: lower-roman;"><li>Are they all legible?<br></li></ol></li><li>Do you get the documents you use when you need them?<br></li></ol></li><li>Note if you observe any obsolete or invalid documents in the area. Describe the situation.</li></ol>

EOT
}

tasks << {
:name => "NPP Process Infrastructure",
:instructions => <<EOT
<ol><li>What equipment, tools, parts, materials, hardware, or software are required for this process?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Is equipment adequately maintained?<br><ol start="1" style="list-style-type: lower-roman;"><li>Are there any repetitive equipment problems?<br></li></ol></li><li>Are the tools adequate for the process?<br></li><li>Are there any repetitive problems associated with any materials used in the process?<br></li><li>Are materials available when needed?<br></li><li>Is the hardware and software used in the process adequate to meet the needs of process participants? <br></li></ol></li><li>Is the work environment suitable for the process?</li></ol>

EOT
}

tasks << {
:name => "NPP Process Records",
:instructions => <<EOT
<ol><li>What records are generated by the NPP Process?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Are the records legible, readily retrievable, and stored in a way that protects their fitness for use?<br></li></ol></li><li>Have responsibilities for record collection, maintenance and access been clearly defined and documented?<br></li><li>Verify that electronic records are appropriately backed-up and can be restored, if necessary.<br></li><li>What are the performance indicators used to demonstrate effective implementation of the record control process? How are they tracked for continual improvement?<br></li><li>Is there a plan for record disposition?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Are records disposed of in accordance with the plan?</li></ol></li></ol>

EOT
}

tasks << {
:name => "Communication of Quality Policy Statement and Objectives",
:instructions => <<EOT
<ol><li>For a sampling of employees responsible for the NPP Process:<br><ol start="1" style="list-style-type: lower-alpha;"><li>Document their name, position and answers to the following open-ended questions; <br></li><li>Are you aware of the quality policy?<br></li><li>Can you state the key concepts in your own words?<br></li><li>How does the quality policy relate to your job?<br></li><li>What quality objectives have been established for this process?<br></li><li>Is the organization achieving these quality objectives?<br></li><li>How does what you do impact whether or not the organization will meet these quality objectives?<br></li></ol></li><li>Summarize your evaluation of whether or not the quality goals and objectives have been adequately communicated to the personnel responsible for the NPP Process.</li></ol>

EOT
}


template.tasks = tasks.to_json
template.save!
