# encoding: UTF-8
puts "Creating ISO 9001:2008 – Control of Monitoring and Measuring Devices Checklist  ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('ISO'),
                               :full_name => 'ISO 9001:2008 Quality Management System Requirements',
                               :display_name => 'ISO 9001',
                               :description => 'ISO 9001:2008 sets out the criteria for a quality management system.',
                               :regulatory_review_name => 'ISO 9001:2008 – Control of Monitoring and Measuring Devices Checklist ',
                               :frequency => 'Annual'.force_encoding('UTF-8'),                            
                               :objectives => "The organization must have in place a suitable process to ensure that product and process monitoring and measuring is conducted in a manner consistent with the requirements to ensure product conformity to the criteria specified for product acceptance.  Read through all the task instructions to understand how to document this review.  Then identify and interview the executive(s) responsible for evaluating the criteria and methods used to ensure the effective operation and control of the calibration process for Monitoring and Measuring Devices (MMDs).  Note any exceptions to the organization’s QMS policy and report to the appropriate person for corrective action.  When you identify methods to improve a process, document your findings and forward to the appropriate person.".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "MMD Calibration Process",
:instructions => <<EOT
<ol><li>Identify the process owner who can properly describe the quality metrics for the calibration of MMDs. In the workspace below, provide the process owner’s name, title, date interviewed and state why this individual is qualified to participate in the calibration of MMDs quality management review.<br></li><li>Document the process owner’s answers to the following questions:<br><ol start="1" style="list-style-type: lower-alpha;"><li>Describe the MMD calibration process at your organization.<br><ol start="1" style="list-style-type: lower-roman;"><li>Does it include both process and product testing equipment? <br></li><li>Does the calibration process include any quality-critical equipment owned by others?<br></li></ol></li><li>Are all standards used to calibrate instruments traceable to a nationally recognized standard such as NIST?<br><ol start="1" style="list-style-type: lower-roman;"><li>If not, what is the basis used for calibration and is it clearly documented?<br></li></ol></li><li>Attach Certificates of Traceability (or other basis for calibration) for 5 standards used in the organization’s calibration process.<br></li><li>If external MMD calibration services are used, how is the quality of the services verified?<br><ol start="1" style="list-style-type: lower-roman;"><li>Are the providers of the service ISO 9001 or sector-specific certified?</li></ol></li></ol></li></ol>

EOT
}

tasks << {
:name => "MMD Calibration Metrics",
:instructions => <<EOT
<ol><li>Document the MMD calibration process owner’s verbal answers to the following questions:<br><ol start="1" style="list-style-type: lower-alpha;"><li>What metrics do you use to evaluate the effectiveness of the MMD calibration process?<br><ol start="1" style="list-style-type: lower-roman;"><li>Who monitors these metrics? ii. How is each metric evaluated?<br></li></ol></li><li>Do you have goals and objectives established for each metric?<br></li><li>Are the goals and objectives for each being achieved?<br><ol start="1" style="list-style-type: lower-roman;"><li>Attach documents evidencing whether or not these goals are being achieved.<br></li></ol></li><li>If goals are NOT being met, ask: “What actions are being taken to improve the process?”<br></li><li>If goals ARE being met, ask: “How are the processes reviewed for opportunities of continual improvement?”</li></ol></li></ol>

EOT
}

tasks << {
:name => "MMD Calibration Verification",
:instructions => <<EOT
<ol><li>Select up to 5 MMDs and document for each:<br><ol start="1" style="list-style-type: lower-alpha;"><li>Name of MMD audited (include unique identifier) for completing this task;<br></li><li>Note if calibration status is current;<br></li><li>Describe the condition of the MMD;<br></li><li>Record how frequently accuracy is checked;<br></li><li>Check to determine if accuracy test results are or are not within acceptable limits;<br></li><li>Document if the standard used to check the MMD is traceable to a nationally recognized standard or not.<br></li><li>If not, describe the standard used.</li></ol></li></ol>

EOT
}

tasks << {
:name => "MMD Calibration Assessment",
:instructions => <<EOT
<ol><li>Verify that MMDs are handled in a way that protects their fitness for use.<br></li><li>Document how MMDs are protected against adjustments that would invalidate calibration settings.<br></li><li>Review records to identify if any MMDs were repetitively found to be out of calibration.<br><ol start="1" style="list-style-type: lower-alpha;"><li>If any were repetitively out of calibration, document the actions taken with both the MMD and any products that may have been tested with that MMD when it was out of calibration.<br></li></ol></li><li>Review records to identify if any MMDs were out of calibration when initially checked.<br><ol start="1" style="list-style-type: lower-alpha;"><li>For those MMDs out or calibration when initially checked, document the actions taken with both the MMD and any products that may have been tested with that MMD.<br></li></ol></li><li>Identify all software included in the MMD calibration process. a. Verify that it is properly used according to the manufacturer’s recommendations.</li></ol>

EOT
}

tasks << {
:name => "MMD Calibration Customers",
:instructions => <<EOT
<ol><li>If applicable, interview any internal customers (such as manufacturing, quality control lab, etc.) of MMD calibration services and document if they believe from their perspective the process is effective.<br></li><li>If there are no internal customers of the process, please note.</li></ol>

EOT
}

tasks << {
:name => "MMD Calibration Responsibilities",
:instructions => <<EOT
<ol><li>Who participates in the MMD calibration process? Document their positions/titles.<br></li><li>What are the responsibilities for each individual?<br></li><li>How is their authority defined and communicated?</li></ol>

EOT
}

tasks << {
:name => "MMD Calibration Competence",
:instructions => <<EOT
<ol><li>Has the organization defined the skills and knowledge (competence) required to perform the jobs in this process?<br></li><li>Is training provided to ensure that employees are competent? Describe the training.<br></li><li>Did the training include awareness of the importance of the employee’s activities in achieving the organization’s quality policy and objectives?<br></li><li>How is training evaluated for effectiveness?<br></li><li>Attach documents evidencing training records for employees new to the organization or the position. Be sure to obtain records for management, technical, and administrative personnel.</li></ol>

EOT
}

tasks << {
:name => "Training Evaluation",
:instructions => <<EOT
<ol><li>Interview each new employee identified in Task7-5 above and document his/her answer to the following questions:<br><ol start="1" style="list-style-type: lower-alpha;"><li>How would you rate the training process on a scale of 1 to 10, with 1 being unacceptable and 10 excellent?<br><ol start="1" style="list-style-type: lower-roman;"><li>If 8 or above, record the answer and this task is completed for this new employee.<br></li><li>If 7 or below, document the answers to Questions b and c below.<br></li></ol></li><li>What specific knowledge did you need that was not provided?<br><ol start="1" style="list-style-type: lower-roman;"><li>Verify that this specific training was, in fact, not provided. <br></li><li>Describe the knowledge areas the employee states need improvement.<br></li></ol></li><li>What additional training did you wish you had received?<br><ol start="1" style="list-style-type: lower-roman;"><li>Did lack of that training create a problem for you? If yes, please describe the problem and how additional training would have avoided/solved the problem.</li></ol></li></ol></li></ol>

EOT
}

tasks << {
:name => "MMD Calibration Information",
:instructions => <<EOT
<ol><li>What types of documents are used in the MMD calibration process? (These may include procedures, work instructions, test methods, job descriptions, specifications, prints, check sheets, batch sheets, control plans, etc. and they may be in paper or electronic form.)<br><ol start="1" style="list-style-type: lower-alpha;"><li>Note which of these are external documents, such as customer drawings or supplier material/part specifications, and how they are identified as external documents.<br></li></ol></li><li>What is the revision control system for managing internal documents?<br><ol start="1" style="list-style-type: lower-alpha;"><li>What is the process for approving revisions?<br></li><li>How frequently are documents reviewed for adequacy?<br></li></ol></li><li>What is the control system for managing external documents?<br></li><li>Select a sampling of process participants and document each one’s answer to the following questions:<br><ol start="1" style="list-style-type: lower-alpha;"><li>Do the documents you use include the proper type and amount of information?<br></li><li>Are changes to the documents you use clearly identified?<br></li><li>Are there any problems with the documents you use?<br><ol start="1" style="list-style-type: lower-roman;"><li>Are they all legible?<br></li></ol></li><li>Do you get the documents you use when you need them?<br></li></ol></li><li>Note if you observe any obsolete or invalid documents in the area. Describe the situation.</li></ol>

EOT
}

tasks << {
:name => "MMD Calibration Process Infrastructure",
:instructions => <<EOT
<ol><li>What equipment, tools, parts, materials, hardware, or software are required for this process?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Is equipment adequately maintained?<br><ol start="1" style="list-style-type: lower-roman;"><li>Are there any repetitive equipment problems?<br></li></ol></li><li>Are the tools adequate for the process?<br></li><li>Are there any repetitive problems associated with any materials used in the process?<br></li><li>Are materials available when needed?<br></li><li>Is the hardware and software used in the process adequate to meet the needs of process participants?<br></li></ol></li><li>Is the work environment suitable for the process?</li></ol>

EOT
}

tasks << {
:name => "MMD Calibration Records",
:instructions => <<EOT
<ol><li>What records are generated by the MMD calibration process?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Are the records legible, readily retrievable, and stored in a way that protects their fitness for use?<br></li></ol></li><li>Have responsibilities for record collection, maintenance and access been clearly defined and documented?<br></li><li>Verify that electronic records are appropriately backed-up and can be restored, if necessary.<br></li><li>What are the performance indicators used to demonstrate effective implementation of the record control process? How are they tracked for continual improvement?<br></li><li>Is there a plan for record disposition?<br><ol start="1" style="list-style-type: lower-alpha;"><li>Are records disposed of in accordance with the plan?</li></ol></li></ol>

EOT
}

tasks << {
:name => "Communication of Quality Policy Statement and Objectives",
:instructions => <<EOT
<ol><li>For a sampling of employees responsible for and conducting MMD calibration:<br><ol start="1" style="list-style-type: lower-alpha;"><li>Document their name, position and answers to the following open-ended questions;<br></li><li>Are you aware of the quality policy?<br></li><li>Can you state the key concepts in your own words?<br></li><li>How does the quality policy relate to your job?<br></li><li>What quality objectives have been established for this process?<br></li><li>Is the organization achieving these quality objectives?<br></li><li>How does what you do impact whether or not the organization will meet these quality objectives?<br></li></ol></li><li>Summarize your evaluation of whether or not the quality goals and objectives have been adequately communicated to the personnel responsible for MMD calibration.</li></ol>

EOT
}


template.tasks = tasks.to_json
template.save!
