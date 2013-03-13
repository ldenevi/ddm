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
1. Identify the process owner who can properly describe how the organization defines and documents customer requirements for new products.  In the workspace below, provide the process owner's name, title, date interviewed and state why this individual is qualified to participate in the Purchasing quality management review.  
2. Document the process owner's description of the organization's Product Realization Process.

EOT
}

tasks << {
:name => "NPP Metrics",
:instructions => <<EOT
1. Document the NPP process owner's verbal answers to the following questions:
  a. What metrics do you use to evaluate the effectiveness of the NPP process?  For example, productivity; reduction of cycle time, errors, omissions and failures, on-time delivery, etc.
    i. Who monitors these metrics? 
    ii. How is each metric evaluated?
  b. Do you have goals and objectives established for each metric?
  c. Are the goals and objectives for each being achieved? 
    i. Attach documents evidencing whether or not these goals are being achieved.
  d. If goals are NOT being met, ask: "What actions are being taken to improve the process?"
  e. If goals ARE being met, ask: "How are the processes reviewed for opportunities of continual improvement?"

EOT
}

tasks << {
:name => "NPP Customer Requirements",
:instructions => <<EOT
1. Describe how your organization defines and documents customer requirements.
  a. Attach the documents defining the customer requirements for new products.
2. Does documentation (for example, customer contracts, RFQs, RFPs, product specifications, packaging standards, orders, and so on) clearly and adequately define customer requirements including delivery and post-delivery requirements?
3. Do defined requirements include product-related statutory and regulatory requirements and any other requirement not necessarily stated by the customer but required for the product's known and intended use?
4. How are changes to customer requirements reviewed?
  a. By whom?
  b. What records are maintained?
  c. How are affected employees

EOT
}

tasks << {
:name => "NPP Verification",
:instructions => <<EOT
1. Select a random sampling of new products or processes and verify the following:
  a. Were product or service requirements and quality objectives defined?
  b. Did your organization verify that it had the capability of meeting the customers' requirements prior to accepting the order?  Who was responsible?
  c. Were current processes, documentation, and resources evaluated to ensure that they were suitable for the new product or process?
  d. Were verification, validation, inspection, and test requirements defined? Did they include acceptance criteria?
  e. Were any new records identified that would be necessary for these products, processes, or projects? If yes, please list.
  f. If your organization could not meet the customer's requirements - including ship date - or if requirements on the order are difference from those on the contract, how was that resolved with the customer? By whom? What written records were kept? (Pull records to verify conformance.)

EOT
}

tasks << {
:name => "NPP Customer Communications",
:instructions => <<EOT
1. Has the organization established effective arrangements for communications with customers regarding the following:
  a. New product information;
  b. Inquires, contracts and order handling;
  c. Customer feedback - including complaints;
    i. Has the complaint file been reviewed for repetitive complaints?  If repetitive complaints were found, was corrective action taken?

EOT
}

tasks << {
:name => "NPP Customers",
:instructions => <<EOT
1. Interview any internal customers (such as manufacturing, shipping, etc.) of the NPP Process and document from their perspective the effectiveness of the output of the NPP Process.
  a. For example, are operations personnel receiving appropriate materials when needed to run the manufacturing process?
  b. For example, are shipping personnel receiving the right packaging and customer labeling instructions?

EOT
}

tasks << {
:name => "NPP Process Responsibilities",
:instructions => <<EOT
1. Who participates in the NPP Process?  Document their positions/titles.
2. What are the responsibilities for each individual?
3. How is their authority defined and communicated?

EOT
}

tasks << {
:name => "NP Process Competence",
:instructions => <<EOT
1. Has the organization defined the skills and knowledge (competence) required to perform the jobs in this process?
2. Is training provided to ensure that employees are competent? Describe the training.
3. Did the training include awareness of the importance of the employee's activities in achieving the organization's quality policy and objectives?
4. How is training evaluated for effectiveness?
5. Attach documents evidencing training records for employees new to the organization or the position.  Be sure to obtain records for management, technical, and administrative personnel.

EOT
}

tasks << {
:name => "NPP Process Training Evaluation",
:instructions => <<EOT
1. Interview each new employee identified in Task 8-5 above and document his/her answer to the following questions:
  a. How would you rate the training process on a scale of 1 to 10, with 1 being unacceptable and 10 excellent?
    i. If 8 or above, record the answer and this task is completed for this new employee.
    ii. If 7 or below, document the answers to Questions b and c below.  
  b. What specific knowledge did you need that was not provided?  
    i. Verify that this specific training was, in fact, not provided.  
    ii. Describe the knowledge areas the employee states need improvement.
  c. What additional training did you wish you had received?  
    i. Did lack of that training create a problem for you?  If yes, please describe the problem and how additional training would have avoided/solved the problem.

EOT
}

tasks << {
:name => "NPP Process Information",
:instructions => <<EOT
1. What types of documents are used in the NPP Process? (These may include procedures, work instructions, test methods, job descriptions, specifications, prints, check sheets, batch sheets, control plans, etc. and they may be in paper or electronic form.)
  a. Note which of these are external documents, such as customer drawings or supplier material/part specifications, and how they are identified as external documents.
2. What is the revision control system for managing internal documents?
  a. What is the process for approving revisions?
  b. How frequently are documents reviewed for adequacy?
3. What is the control system for managing external documents?
4. Select a sampling of process participants and document each one's answer to the following questions:
  a. Do the documents you use include the proper type and amount of information?
  b. Are changes to the documents you use clearly identified?
  c. Are there any problems with the documents you use?
    i. Are they all legible?
  d. Do you get the documents you use when you need them?
5. Note if you observe any obsolete or invalid documents in the area.  Describe the situation.

EOT
}

tasks << {
:name => "NPP Process Infrastructure",
:instructions => <<EOT
1. What equipment, tools, parts, materials, hardware, or software are required for this process?
  a. Is equipment adequately maintained? 
    i. Are there any repetitive equipment problems?
  b. Are the tools adequate for the process?
  c. Are there any repetitive problems associated with any materials used in the process?
  d. Are materials available when needed?
  e. Is the hardware and software used in the process adequate to meet the needs of process participants?
2. Is the work environment suitable for the process?

EOT
}

tasks << {
:name => "NPP Process Records",
:instructions => <<EOT
1. What records are generated by the NPP Process?
  a. Are the records legible, readily retrievable, and stored in a way that protects their fitness for use?
2. Have responsibilities for record collection, maintenance and access been clearly defined and documented?
3. Verify that electronic records are appropriately backed-up and can be restored, if necessary.
4. What are the performance indicators used to demonstrate effective implementation of the record control process? How are they tracked for continual improvement?
5. Is there a plan for record disposition? 
  a. Are records disposed of in accordance with the plan?

EOT
}

tasks << {
:name => "Communication of Quality Policy Statement and Objectives",
:instructions => <<EOT
1. For a sampling of employees responsible for the NPP Process:
  a. Document their name, position and answers to the following open-ended questions;
    a. Are you aware of the quality policy?
    b. Can you state the key concepts in your own words?
    c. How does the quality policy relate to your job?
    d. What quality objectives have been established for this process?
    e. Is the organization achieving these quality objectives?
    f. How does what you do impact whether or not the organization will meet these quality objectives?
2. Summarize your evaluation of whether or not the quality goals and objectives have been adequately communicated to the personnel responsible for the NPP Process.


EOT
}


template.tasks = tasks.to_json
template.save!
