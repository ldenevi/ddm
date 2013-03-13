# encoding: UTF-8
puts "Creating ISO 9001:2008 sets out the criteria for a quality management system. ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('ISO'),
                               :full_name => 'ISO 9001:2008 Quality Management System Requirements',
                               :display_name => 'ISO 9001',
                               :description => 'ISO 9001:2008 sets out the criteria for a quality management system.',
                               :regulatory_review_name => 'ISO 9001:2008 sets out the criteria for a quality management system.',
                               :frequency => 'Annual'.force_encoding('UTF-8'),                            
                               :objectives => "The organization must have in place a suitable process to ensure the product design and development process is comprehensive and focuses on error prevention.  Read through all the task instructions to understand how to document this review.  Then identify and interview the executive(s) responsible for evaluating the criteria and methods used to ensure the effective operation and control of the design and development process.  Note any exceptions to the organization’s QMS policy and report to the appropriate person for corrective action.  When you identify methods to improve a process, document your findings and forward to the appropriate person.".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "Design and Development Process",
:instructions => <<EOT
1.	Identify the process owner who can properly describe the phases and quality metrics of the Design and Development Process (D&D).  In the workspace below, provide the process owner’s name, title, date interviewed and state why this individual is qualified to participate in the D&D quality management review.  
2.	Document the process owner’s description of your organization’s D&D Process.

EOT
}

tasks << {
:name => "D&D Metrics",
:instructions => <<EOT
1.	Document the D&D process owner’s verbal answers to the following questions:
a.	What metrics do you use to evaluate the effectiveness of the D&D process?  For example, design and development cycle times, D&D costs, measurable improvements in the product developed, etc.
i.	Who monitors these metrics? 
ii.	How is each metric evaluated?
b.	Do you have goals and objectives established for each metric?
c.	Are the goals and objectives for each being achieved? 
i.	Attach documents evidencing whether or not these goals are being achieved.
d.	If goals are NOT being met, ask: “What actions are being taken to improve the process?”
e.	If goals ARE being met, ask: “How are the processes reviewed for opportunities of continual improvement?”

EOT
}

tasks << {
:name => "D&D Process Verification",
:instructions => <<EOT
1.	Select a sampling of recently closed D&D Projects and document your findings for a-q for each Project.  (If the answer to any question below is “No” for any Project, describe the issue and note any follow-up and/or corrective action required):
a.	Name of D&D Projects audited (include unique identifier) for completing this task;
b.	Was there a design plan for each project?
c.	Were “lessons learned” from previous projects reviewed at the beginning of each project?
d.	Did plans identify specific activities and the individual responsible for completing them?
e.	Did plans include the review, verification, and validation activities that are appropriate to each stage of the design?
f.	Were there interfaces, such as manufacturing, purchasing, and customers, identified for each project? Were they kept abreast of the status of the design? (Attach records verifying conformance.)
g.	Was the plan updated as necessary as the project evolved?
h.	Were customer and regulatory requirements clearly defined for each project along with the functional and performance requirements for the product? Were these requirements reviewed and approved? (Attach record verifying conformance.)
i.	Is there evidence for each project that the design output (that is, prints, drawings, specifications, verification and validation results, and so on) met the customer and regulatory requirements specified in the question above?
j.	Did design output include or reference acceptance criteria?
k.	Do the output documents specify the characteristics of the product that are essential for its safe and proper use?
l.	Are records available to show evidence of design review for each project at the required intervals?  Were appropriate functions involved in each review? Were follow-up activities recorded?
m.	Were verification requirements clearly defined and documented? (Attach records verifying that requirements were successfully completed or that follow-up activities were recorded.)
n.	Were validation requirements clearly defined and documented? (Attach records validating that requirements were successfully completed or that follow-up activities were recorded.)
o.	Have any of the projects had changes?  (If so, verify that they were reviewed, verified, validated, and approved as appropriate.) 
p.	Was the effect of the change on other parts, such as packaging, attached components, instruction manuals, etc., or the finished product evaluated? 
q.	Do records include the results of the change reviews as well as any necessary actions? 

EOT
}

tasks << {
:name => "D&D Process Customers",
:instructions => <<EOT
1.	Interview any internal customers (such as manufacturing, purchasing, etc.) of the D&D Process and document from their perspective the effectiveness of the output of the D&D Process.
a.	Are operations personnel receiving adequate information to run the manufacturing process?
b.	Are purchasing personnel receiving adequate information (on raw material specs, and so on) in time to order acceptable materials from qualified suppliers?
c.	Are QA personnel receiving adequate information in time to effectively test the new product?
d.	Are maintenance personnel receiving adequate information to effectively maintain the equipment?

EOT
}

tasks << {
:name => "D&D Process Responsibilities",
:instructions => <<EOT
1.	Who participates in the D&D Process?  Document their positions/titles.
2.	What are the responsibilities for each individual?
3.	How is their authority defined and communicated?

EOT
}

tasks << {
:name => "D&D Process Competence",
:instructions => <<EOT
1.	Has the organization defined the skills and knowledge (competence) required to perform the jobs in this process?
2.	Is training provided to ensure that employees are competent? Describe the training.
3.	Did the training include awareness of the importance of the employee’s activities in achieving the organization’s quality policy and objectives?
4.	How is training evaluated for effectiveness?
5.	Attach documents evidencing training records for employees new to the organization or the position.  Be sure to obtain records for management, technical, and administrative personnel.

EOT
}

tasks << {
:name => "D&D Process Training Evaluation",
:instructions => <<EOT
1.	Interview each new employee identified in Task 6-5 above and document his/her answer to the following questions:
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
:name => "D&D Process Information",
:instructions => <<EOT
1.	What types of documents are used in the D&D Process? (These may include procedures, work instructions, test methods, job descriptions, specifications, prints, check sheets, batch sheets, control plans, etc. and they may be in paper or electronic form.)
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
:name => "D&D Process Infrastructure",
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
:name => "D&D Process Records",
:instructions => <<EOT
1.	What records are generated by the D&D Process?
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
1.	For a sampling of employees responsible for the D&D Process:
a.	Document their name, position and answers to the following open-ended questions;
a.	Are you aware of the quality policy?
b.	Can you state the key concepts in your own words?
c.	How does the quality policy relate to your job?
d.	What quality objectives have been established for this process?
e.	Is the organization achieving these quality objectives?
f.	How does what you do impact whether or not the organization will meet these quality objectives?
2.	Summarize your evaluation of whether or not the quality goals and objectives have been adequately communicated to the personnel responsible for D&D Process.

EOT
}


template.tasks = tasks.to_json
template.save!
