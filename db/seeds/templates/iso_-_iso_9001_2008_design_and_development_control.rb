# encoding: UTF-8
puts "Creating ISO 9001:2008 Design and Development Control ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('ISO'),
                               :full_name => 'ISO 9001:2008 Quality Management System Requirements',
                               :display_name => 'ISO 9001',
                               :description => 'ISO 9001:2008 sets out the criteria for a quality management system.',
                               :regulatory_review_name => 'ISO 9001:2008 Design and Development Control',
                               :frequency => 'Annual'.force_encoding('UTF-8'),
                               :objectives => "<p>The organization must have in place a suitable process to ensure the product design and development process is comprehensive and focuses on error prevention. Read through all the task instructions to understand how to document this review. Then identify and interview the executive(s) responsible for evaluating the criteria and methods used to ensure the effective operation and control of the design and development process. Note any exceptions to the organization&rsquo;s QMS policy and report to the appropriate person for corrective action. When you identify methods to improve a process, document your findings and forward to the appropriate person.</p>
".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "Design and Development Process",
:instructions => <<EOT
<ol>
	<li>Identify the process owner who can properly describe the phases and quality metrics of the Design and Development Process (D&amp;D). In the workspace below, provide the process owner&rsquo;s name, title, date interviewed and state why this individual is qualified to participate in the D&amp;D quality management review.</li>
	<li>Document the process owner&rsquo;s description of your organization&rsquo;s D&amp;D Process.</li>
</ol>

EOT
}

tasks << {
:name => "D&D Metrics",
:instructions => <<EOT
<ol>
	<li>Document the D&amp;D process owner&rsquo;s verbal answers to the following questions:
	<ol start="1" style="list-style-type: lower-alpha;">
		<li>a. What metrics do you use to evaluate the effectiveness of the D&amp;D process? For example, design and development cycle times, D&amp;D costs, measurable improvements in the product developed, etc.
		<ol start="1" style="list-style-type: lower-roman;">
			<li>Who monitors these metrics?</li>
			<li>How is each metric evaluated?</li>
		</ol>
		</li>
		<li>Do you have goals and objectives established for each metric?</li>
		<li>Are the goals and objectives for each being achieved?
		<ol start="1" style="list-style-type: lower-roman;">
			<li>Attach documents evidencing whether or not these goals are being achieved.</li>
		</ol>
		</li>
		<li>If goals are NOT being met, ask: &ldquo;What actions are being taken to improve the process?&rdquo;</li>
		<li>If goals ARE being met, ask: &ldquo;How are the processes reviewed for opportunities of continual improvement?&rdquo;</li>
	</ol>
	</li>
</ol>

EOT
}

tasks << {
:name => "D&D Process Verification",
:instructions => <<EOT
<ol>
	<li>Select a sampling of recently closed D&amp;D Projects and document your findings for a-q for each Project. (If the answer to any question below is &ldquo;No&rdquo; for any Project, describe the issue and note any follow-up and/or corrective action required):
	<ol start="1" style="list-style-type: lower-alpha;">
		<li>Name of D&amp;D Projects audited (include unique identifier) for completing this task;</li>
		<li>Was there a design plan for each project?</li>
		<li>Were &ldquo;lessons learned&rdquo; from previous projects reviewed at the beginning of each project?</li>
		<li>Did plans identify specific activities and the individual responsible for completing them?</li>
		<li>Did plans include the review, verification, and validation activities that are appropriate to each stage of the design?</li>
		<li>Were there interfaces, such as manufacturing, purchasing, and customers, identified for each project? Were they kept abreast of the status of the design? (Attach records verifying conformance.)</li>
		<li>Was the plan updated as necessary as the project evolved?</li>
		<li>Were customer and regulatory requirements clearly defined for each project along with the functional and performance requirements for the product? Were these requirements reviewed and approved? (Attach record verifying conformance.)</li>
		<li>Is there evidence for each project that the design output (that is, prints, drawings, specifications, verification and validation results, and so on) met the customer and regulatory requirements specified in the question above?</li>
		<li>Did design output include or reference acceptance criteria?</li>
		<li>Do the output documents specify the characteristics of the product that are essential for its safe and proper use?</li>
		<li>Are records available to show evidence of design review for each project at the required intervals? Were appropriate functions involved in each review? Were follow-up activities recorded?</li>
		<li>Were verification requirements clearly defined and documented? (Attach records verifying that requirements were successfully completed or that follow-up activities were recorded.)</li>
		<li>Were validation requirements clearly defined and documented? (Attach records validating that requirements were successfully completed or that follow-up activities were recorded.)</li>
		<li>Have any of the projects had changes? (If so, verify that they were reviewed, verified, validated, and approved as appropriate.)</li>
		<li>Was the effect of the change on other parts, such as packaging, attached components, instruction manuals, etc., or the finished product evaluated?</li>
		<li>Do records include the results of the change reviews as well as any necessary actions?</li>
	</ol>
	</li>
</ol>

EOT
}

tasks << {
:name => "D&D Process Customers",
:instructions => <<EOT
<ol>
	<li>Interview any internal customers (such as manufacturing, purchasing, etc.) of the D&amp;D Process and document from their perspective the effectiveness of the output of the D&amp;D Process.
	<ol start="1" style="list-style-type: lower-alpha;">
		<li>Are operations personnel receiving adequate information to run the manufacturing process?</li>
		<li>Are purchasing personnel receiving adequate information (on raw material specs, and so on) in time to order acceptable materials from qualified suppliers?</li>
		<li>Are QA personnel receiving adequate information in time to effectively test the new product?</li>
		<li>Are maintenance personnel receiving adequate information to effectively maintain the equipment?</li>
	</ol>
	</li>
</ol>

EOT
}

tasks << {
:name => "D&D Process Responsibilities",
:instructions => <<EOT
<ol>
	<li>Who participates in the D&amp;D Process? Document their positions/titles.</li>
	<li>What are the responsibilities for each individual? 3. How is their authority defined and communicated?</li>
</ol>

EOT
}

tasks << {
:name => "D&D Process Competence",
:instructions => <<EOT
<ol>
	<li>Has the organization defined the skills and knowledge (competence) required to perform the jobs in this process?</li>
	<li>Is training provided to ensure that employees are competent? Describe the training.</li>
	<li>Did the training include awareness of the importance of the employee&rsquo;s activities in achieving the organization&rsquo;s quality policy and objectives?</li>
	<li>How is training evaluated for effectiveness?</li>
	<li>Attach documents evidencing training records for employees new to the organization or the position. Be sure to obtain records for management, technical, and administrative personnel.</li>
</ol>

EOT
}

tasks << {
:name => "D&D Process Training Evaluation",
:instructions => <<EOT
<ol>
	<li>Interview each new employee identified in Task 6-5 above and document his/her answer to the following questions:
	<ol start="1" style="list-style-type: lower-alpha;">
		<li>How would you rate the training process on a scale of 1 to 10, with 1 being unacceptable and 10 excellent?
		<ol start="1" style="list-style-type: lower-roman;">
			<li>If 8 or above, record the answer and this task is completed for this new employee.</li>
			<li>If 7 or below, document the answers to Questions b and c below.</li>
		</ol>
		</li>
		<li>What specific knowledge did you need that was not provided?
		<ol start="1" style="list-style-type: lower-roman;">
			<li>Verify that this specific training was, in fact, not provided.</li>
			<li>Describe the knowledge areas the employee states need improvement.</li>
		</ol>
		</li>
		<li>What additional training did you wish you had received?
		<ol start="1" style="list-style-type: lower-roman;">
			<li>Did lack of that training create a problem for you? If yes, please describe the problem and how additional training would have avoided/solved the problem.</li>
		</ol>
		</li>
	</ol>
	</li>
</ol>

EOT
}

tasks << {
:name => "D&D Process Information",
:instructions => <<EOT
<ol>
	<li>What types of documents are used in the D&amp;D Process? (These may include procedures, work instructions, test methods, job descriptions, specifications, prints, check sheets, batch sheets, control plans, etc. and they may be in paper or electronic form.) a. Note which of these are external documents, such as customer drawings or supplier material/part specifications, and how they are identified as external documents.</li>
	<li>What is the revision control system for managing internal documents?
	<ol start="1" style="list-style-type: lower-alpha;">
		<li>What is the process for approving revisions?</li>
		<li>How frequently are documents reviewed for adequacy?</li>
	</ol>
	</li>
	<li>What is the control system for managing external documents?</li>
	<li>Select a sampling of process participants and document each one&rsquo;s answer to the following questions:
	<ol start="1" style="list-style-type: lower-alpha;">
		<li>Do the documents you use include the proper type and amount of information?</li>
		<li>Are changes to the documents you use clearly identified?</li>
		<li>Are there any problems with the documents you use?
		<ol start="1" style="list-style-type: lower-roman;">
			<li>Are they all legible?</li>
		</ol>
		</li>
		<li>Do you get the documents you use when you need them?</li>
	</ol>
	</li>
	<li>Note if you observe any obsolete or invalid documents in the area. Describe the situation.</li>
</ol>

EOT
}

tasks << {
:name => "D&D Process Infrastructure",
:instructions => <<EOT
<ol>
	<li>What equipment, tools, parts, materials, hardware, or software are required for this process?
	<ol start="1" style="list-style-type: lower-alpha;">
		<li>Is equipment adequately maintained?
		<ol start="1" style="list-style-type: lower-roman;">
			<li>Are there any repetitive equipment problems?</li>
		</ol>
		</li>
		<li>Are the tools adequate for the process?</li>
		<li>Are there any repetitive problems associated with any materials used in the process?</li>
		<li>Are materials available when needed?</li>
		<li>Is the hardware and software used in the process adequate to meet the needs of process participants?</li>
	</ol>
	</li>
	<li>Is the work environment suitable for the process?</li>
</ol>

EOT
}

tasks << {
:name => "D&D Process Records",
:instructions => <<EOT
<ol>
	<li>What records are generated by the D&amp;D Process?
	<ol start="1" style="list-style-type: lower-alpha;">
		<li>Are the records legible, readily retrievable, and stored in a way that protects their fitness for use?</li>
	</ol>
	</li>
	<li>Have responsibilities for record collection, maintenance and access been clearly defined and documented?</li>
	<li>Verify that electronic records are appropriately backed-up and can be restored, if necessary.</li>
	<li>What are the performance indicators used to demonstrate effective implementation of the record control process? How are they tracked for continual improvement?</li>
	<li>Is there a plan for record disposition?
	<ol start="1" style="list-style-type: lower-alpha;">
		<li>Are records disposed of in accordance with the plan?</li>
	</ol>
	</li>
</ol>

EOT
}

tasks << {
:name => "Communication of Quality Policy Statement and Objectives",
:instructions => <<EOT
<ol>
	<li>For a sampling of employees responsible for the D&amp;D Process:
	<ol start="1" style="list-style-type: lower-alpha;">
		<li>Document their name, position and answers to the following open-ended questions;
		<ol start="1" style="list-style-type: lower-roman;">
			<li>Are you aware of the quality policy?</li>
			<li>Can you state the key concepts in your own words?</li>
			<li>How does the quality policy relate to your job?</li>
			<li>What quality objectives have been established for this process?</li>
			<li>Is the organization achieving these quality objectives?</li>
			<li>How does what you do impact whether or not the organization will meet these quality objectives?</li>
		</ol>
		</li>
	</ol>
	</li>
	<li>Summarize your evaluation of whether or not the quality goals and objectives have been adequately communicated to the personnel responsible for D&amp;D Process.</li>
</ol>

EOT
}


template.tasks = tasks.to_json
template.save!