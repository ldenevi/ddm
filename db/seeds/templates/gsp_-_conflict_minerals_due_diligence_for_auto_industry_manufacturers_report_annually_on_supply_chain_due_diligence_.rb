# encoding: UTF-8
puts "Creating Conflict Minerals Due Diligence for Auto Industry Manufacturers: Report Annually on Supply Chain Due Diligence  ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('GSP'),
                               :full_name => 'Conflict Minerals, Dodd-Frank Section 1502',
                               :display_name => 'Conflict Minerals',
                               :description => '',
                               :regulatory_review_name => 'Conflict Minerals Due Diligence for Auto Industry Manufacturers: Report Annually on Supply Chain Due Diligence ',
                               :frequency => 'Annual'.force_encoding('UTF-8'),
                               :objectives => "<p><strong>Objective:</strong> To publicly report on due diligence for responsible supply chains of minerals from conflict-affected and high-risk areas in order to generate public confidence in the measures companies are taking.<br />
<em>The recommended tasks do not constitute legal advice.&nbsp; Users should consult with their attorneys about their specific situation.</em></p>
".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "Prepare the firm’s supply chain Due Diligence Report ",
:instructions => <<EOT
<ol>
	<li>To prepare a draft of your firm&rsquo;s Due Diligence Report, use the tasks, instructions and actions recorded in Green Status Pro to document the procedures your firm followed to create a responsible supply chain by following the OECD/AIGA guidelines to:
	<ol style="list-style-type:lower-alpha;">
		<li>Establish strong management systems;</li>
		<li>Identify and assess risk in the supply chain;</li>
		<li>Design and implement a strategy to respond to identified risks;</li>
		<li>Third-party audit of smelters/refiners due diligence practices;</li>
		<li>Report annually on supply chain due diligence.</li>
	</ol>
	</li>
	<li>Note that you only need to go to the Reports section of Green Status Pro and generate a comprehensive report for each review to obtain the information you need for creating your firm&rsquo;s Due Diligence Report.
	<ol style="list-style-type:lower-alpha;">
		<li>Review the information and remove any confidential data that may have been included.</li>
		<li>Identify potential corrective actions to improve your firm&rsquo;s due diligence process.</li>
		<li>Your firm might want to consider customer review, peer review, internal review and/or outside consultant review as sources for corrective action recommendations.</li>
	</ol>
	</li>
	<li>Review the Due Diligence Report with the Conflict Minerals Oversight Reporting Committee and include its recommendations.</li>
	<li>Publish the Due Diligence Report by providing it to the appropriate employees, customers and suppliers and placing it on the firm&rsquo;s Internet website under the page labeled &ldquo;Conflict Minerals Disclosure.&rdquo;</li>
</ol>

EOT
}

tasks << {
:name => "File a Conflict Minerals Report as an exhibit to Form SD describing the due diligence measures taken and disclosing whether products are: DRC Conflict Free, Not DRC Conflict Free, or DRC Conflict Undeterminable",
:instructions => <<EOT
<ol>
	<li>If a filer, engage a securities law firm that is qualified to properly write the reports required for Form SD.&nbsp; Provide the firm with the documentation of your firm&rsquo;s work effort and assist as requested.</li>
	<li>If your firm&rsquo;s customers are not the end-user of a product and your firm is designated as a supplier to other manufacturers, proactively contact your firm&rsquo;s customer&rsquo;s conflict minerals reporting Lead at the beginning of each month in the fourth and first calendar quarter and ask how your firm can provide better support for the customer&rsquo;s preparation of its Conflict Minerals Report.
	<ol style="list-style-type:lower-alpha;">
		<li>Document all requests and present them to your firm&rsquo;s Conflict Minerals Oversight Reporting Committee for potential inclusion in the firm&rsquo;s due diligence process.</li>
	</ol>
	</li>
</ol>

EOT
}

tasks << {
:name => "Meet reporting requirements per the final rules",
:instructions => <<EOT
<p>If a filer, ensure that the firm&rsquo;s Form SD is properly filed with the SEC by May 31.</p>

EOT
}

tasks << {
:name => "Carry out independent 3rd party audit of supply chain",
:instructions => <<EOT
<ol>
	<li>Engage an outside consulting firm that is qualified to review your firm&rsquo;s work product that was created to meet the requirements of the AIGA Conflict Minerals Reporting Checklist and documented with Green Status Pro and charter it to objectively:
	<ol style="list-style-type:lower-alpha;">
		<li>Analyze the supply chain and supply chain risk;</li>
		<li>Assess the effectiveness of the firm&rsquo;s due diligence procedures;</li>
		<li>Recommend corrective actions to enhance the firm&rsquo;s supply chain management to better meet the challenges of cost effectively managing and reporting on conflict minerals.</li>
	</ol>
	</li>
</ol>

EOT
}


template.tasks = tasks.to_json
template.save!
